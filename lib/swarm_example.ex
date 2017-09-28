defmodule MyApp do
  def start_worker(id) do
    {:ok, pid} = Swarm.register_name(id, MyApp.Supervisor, :register, [id])
  end
end
