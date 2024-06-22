defmodule TodoList.GenServer do
  defstruct auto_id: 1, entries: %{}
  use GenServer

  ## Client API
  def start() do
    GenServer.start_link(__MODULE__, %__MODULE__{}, name: __MODULE__)
  end

  def add_entry(entry) do
    GenServer.call(__MODULE__, {:add_entry, entry})
  end

  def get_entries(id) do
    GenServer.call(__MODULE__, {:get_entries, id})
  end

  def update_entry(entry_id, updater_fun) do
    GenServer.cast(__MODULE__, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(entry_id) do
    GenServer.call(__MODULE__, {:delete_entry, entry_id})
  end

  ## Callbacks
  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    IO.inspect(todo_list.entries)
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        old_entry_id = old_entry.id


        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        updated_list = %__MODULE__{todo_list | entries: new_entries}

        {:noreply, updated_list}
    end
  end

  @impl true
  def handle_call({:add_entry, entry}, _from, state) do
    new_auto_id = state.auto_id + 1
    new_entry = Map.put(entry, :id, new_auto_id)
    new_entries = Map.put(state.entries, new_auto_id, new_entry)
    new_state = %__MODULE__{state | auto_id: new_auto_id, entries: new_entries}
    {:reply, {new_state.auto_id, new_state.entries}, new_state}
  end

  @impl true
  def handle_call({:delete_entry, entry_id}, _from, todo_list) do
    updated_list = Map.delete(todo_list.entries, entry_id)
    {:reply, updated_list, todo_list}
  end

  @impl true
  def handle_call({:get_entries, id}, _from, state) do
    new_state = Map.delete(state.entries, id)
    {:reply, new_state, state}
  end
end
