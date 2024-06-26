# defmodule TodoList do
#   defstruct auto_id: 1, entries: %{}

#   def new(entries \\ []) do
#     Enum.reduce(
#       entries,
#       %TodoList{},
#       fn entry, todo_list_acc ->
#         add_entry(todo_list_acc, entry)
#       end
#     )
#   end

#   def entries(todo_list, date) do
#     todo_list.entries
#     |> Stream.filter(fn {_, entry} -> entry.date == date end)
#     |> Enum.map(fn {_, entry} -> entry end)
#   end

#   def add_entry(todo_list, entry) do
#     entry = Map.put(entry, :id, todo_list.auto_id)

#     new_entries = Map.put(
#       todo_list.entries,
#       todo_list.auto_id,
#       entry
#     )

#     %TodoList{todo_list |
#       entries: new_entries,
#       auto_id: todo_list.auto_id + 1
#     }
#   end

#   def update_entry(todo_list, entry_id, updater_fun) do
#     case Map.fetch(todo_list.entries, entry_id) do
#       :error -> todo_list

#       {:ok, old_entry} ->
#         old_entry_id = old_entry.id
#         new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
#         new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
#         %TodoList{todo_list | entries: new_entries}
#     end
#   end

#   def delete_entry(todo_list, entry_id) do
#     Map.delete(todo_list.entries, entry_id)
#   end
# end

# defmodule TodoListCsvImporter do
#   def new(file) do
#       File.stream!(file)
#       |> Stream.map(&String.trim/1)
#       |> Stream.map(fn element -> String.split(element, ",") |> List.to_tuple() end)
#       |> Stream.map(fn {date, title} -> [String.split(date, "/") |> List.to_tuple(), title] |> List.to_tuple() end)
#       |> Stream.map(fn {{year, month, day}, title} -> {{String.to_integer(year), String.to_integer(month), String.to_integer(day)}, title} end)
#       |> Stream.map(fn {{year, month, day}, title} -> {Date.new!(year, month, day), title} end)
#       |> Enum.map(fn {date, title} -> %{date: date, title: title} end)
#       |> TodoList.new()
#   end
# end
