defmodule TodoListTests do
  use ExUnit.Case
  doctest TodoList

  # new/1
  test "new/1 returns an empty TodoList struct when called without arguments" do
    assert %TodoList{} = TodoList.new
  end

  test "new/1 returns a TodoList struct when called with arguments" do
    # Arrange
    entries = [%{date: ~D[2020-05-10], title: "Dentist"}, %{date: ~D[2020-05-05], title: "Gym"}]

    # Act
    todo_list = TodoList.new(entries)

    # Assert
    entries_length = Enum.count(todo_list.entries)
    assert entries_length = Enum.count(entries)
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

  test "delete_entry/2 successfully deletes an entry" do
    # Arrange
    first_entry = %{date: ~D[2018-12-19], title: "Dentist"}
    second_entry = %{date: ~D[2018-12-20], title: "Dinner"}
    todoList = TodoList.new
      |> TodoList.add_entry(first_entry)
      |> TodoList.add_entry(second_entry)

    # Act
    updated_todoList = TodoList.delete_entry(todoList, 1)

    # Assert
    assert_raise KeyError, fn -> TodoList.entries(updated_todoList, ~D[2018-12-19]) end
  end

  test "TodoListCsvImporter new/1 reads a CSV file and creates a todo list" do
    # Act
    todo_list = TodoListCsvImporter.new("test/todos.csv")

    # Assert
    assert %TodoList{} = todo_list
  end
end
