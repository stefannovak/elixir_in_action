defmodule Todo.DatabaseWorker do
  use GenServer

  @db_folder "./persist"

  def start(folder) do
    GenServer.start(__MODULE__, folder)
  end

  def store(pid, key, data) do
    GenServer.cast(pid, {:store, key, data})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
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
    IO.inspect("I'm here")
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
end
