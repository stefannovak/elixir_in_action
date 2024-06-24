defmodule Todo.Database do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  @impl GenServer
  def init(_) do
    {:ok, worker_one} = Todo.DatabaseWorker.start("a")
    {:ok, worker_two} = Todo.DatabaseWorker.start("b")
    {:ok, worker_three} = Todo.DatabaseWorker.start("c")
    {:ok, %{0 => worker_one, 1 => worker_two, 2 => worker_three}}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, state) do
    {:ok, pid} = choose_worker(key, state)
    Todo.DatabaseWorker.store(pid, key, data)

    {:noreply, state}
  end

  @impl GenServer
  def handle_call({:get, key}, _, state) do
    {:ok, pid}  = choose_worker(key, state)
    data = Todo.DatabaseWorker.get(pid, key)

    {:reply, data, state}
  end

  defp choose_worker(key, state) do
    Map.fetch(state, :erlang.phash2(key, 2))
  end
end
