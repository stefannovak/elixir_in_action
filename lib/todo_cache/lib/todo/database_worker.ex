defmodule Todo.DatabaseWorker do
  use GenServer

  @db_folder "./persist"

  def start_link({folder, worker_id}) do
    IO.puts("Starting database worker #{worker_id} ...")
    GenServer.start_link(
      __MODULE__,
      folder,
      name: via_tuple(worker_id))
  end

  def store(worker_id, key, data) do
    GenServer.cast(via_tuple(worker_id), {:store, key, data})
  end

  def get(worker_id, key) do
    GenServer.call(via_tuple(worker_id), {:get, key})
  end

  @impl GenServer
  def init(folder) do
    File.mkdir_p!("#{@db_folder}/#{folder}")
    {:ok, folder}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, state) do
    key
    |> file_name(state)
    |> File.write!(:erlang.term_to_binary(data))

    {:noreply, state}
  end

  @impl GenServer
  def handle_call({:get, key}, _, state) do
    data =
      case File.read(file_name(key, state)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    {:reply, data, state}
  end

  defp file_name(key, state) do
    Path.join("#{@db_folder}/#{state}", to_string(key))
  end

  defp via_tuple(worker_id) do
    Todo.ProcessRegistry.via_tuple({__MODULE__, worker_id})
  end
end
