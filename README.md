# How to reproduce the bug

1. Start two nodes with names `node1@127.0.0.1` and `node2@127.0.0.1`
2. Start a worker in each node
`MyApp.start_worker 0` and `MyApp.start_worker 1`
If they start in the same node, try with different names.
4. Print registered process info on each node:
`Swarm.registered()`
5. Disconnect the node 2:
`Node.list() |> hd() |> Node.disconnect()`
6. Reconnect node 2:
`Node.connect(:"node1@127.0.0.1")`
7. Print registered process info on each node:
`Swarm.registered()`