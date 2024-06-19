defmodule TodoListTests do
  use ExUnit.Case
  doctest TodoList

  # new/0
  test "new/0 returns an empty TodoList struct" do
    assert %TodoList{} = TodoList.new
  end

  # add_entry/2
  test "add_entry/2 adds an entry to a given todo list" do
    # Arrange
    date = ~D[2018-12-19]
    entry = %{date: date, title: "Dentist"}
    todoList = TodoList.new

    # Act
    new_todoList = TodoList.add_entry(todoList, entry)
    returnedEntry = TodoList.entries(new_todoList, date)

    # Assert
    assert Enum.any?(returnedEntry, & &1.title == "Dentist" and &1.date == date) == true
  end

  # update_entry/3
  test "update_entry/3 should correctly update an entry" do
    # Arrange
    date = ~D[2018-12-19]
    entry = %{date: date, title: "Dentist"}
    todoList = TodoList.new
    new_todoList = TodoList.add_entry(todoList, entry)
    returnedEntries = TodoList.entries(new_todoList, date)
    returnedEntry = Enum.at(returnedEntries, 0)

    # Act
    updated_todoList = TodoList.update_entry(
      new_todoList,
      returnedEntry.id,
      fn %{id: _, date: _, title: oldTitle} ->
         %{id: returnedEntry.id, date: returnedEntry.date, title: String.upcase(oldTitle)}
        end)


    # Assert
    {1, %{id: _, date: _, title: title}} = Enum.at(updated_todoList.entries, 0)
    assert title == String.upcase(entry.title)
  end
end
