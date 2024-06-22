# ElixirInAction

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_in_action` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_in_action, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/elixir_in_action>.

TodoList.GenServer.start()
{new_id, _} = TodoList.GenServer.add_entry(%{date: ~D[2018-12-19], title: "Dentist"})
TodoList.GenServer.get_entries(~D[2018-12-19])

TodoList.GenServer.update_entry(new_id, fn %{id: _, date: _, title: oldTitle} -> %{id: 1, date: ~D[2018-12-19], title: String.upcase(oldTitle)} end)