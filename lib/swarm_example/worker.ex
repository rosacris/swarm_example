defmodule MyApp.Worker do
  use GenServer
  require Logger

  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, args},
      restart: :transient,
      type: :worker
    }
  end

  def start_link(id) do
    GenServer.start_link(__MODULE__, id)
  end

  def init(id) do
    Logger.debug("Starting worker: #{inspect id} on node #{inspect node()}")
    {:ok, id}
  end

  # called when a handoff has been initiated due to changes
  # in cluster topology, valid response values are:
  #
  #   - `:restart`, to simply restart the process on the new node
  #   - `{:resume, state}`, to hand off some state to the new process
  #   - `:ignore`, to leave the process running on it's current node
  #
  def handle_call({:swarm, :begin_handoff}, _from, state) do
    {:reply, :restart, state}
  end
  # called when a network split is healed and the local process
  # should continue running, but a duplicate process on the other
  # side of the split is handing off it's state to us. You can choose
  # to ignore the handoff state, or apply your own conflict resolution
  # strategy
  def handle_cast({:swarm, :resolve_conflict, _delay}, state) do
    {:noreply, state}
  end

  # this message is sent when this process should die
  # because it's being moved, use this as an opportunity
  # to clean up
  def handle_info({:swarm, :die}, state) do
    {:stop, :shutdown, state}
  end
end