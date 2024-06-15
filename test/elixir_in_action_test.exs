defmodule ChapterThreeTest do
  use ExUnit.Case
  doctest ChapterThree

  # list_len

  test "calculates correct length" do
    assert ChapterThree.list_len([1, 5, 3]) == 3
  end

  assert_raise FunctionClauseError, fn ->
    ChapterThree.list_len(5)
  end

  # range

  test "calculates correct range" do
    assert ChapterThree.range(1, 5) == [5, 4, 3, 2, 1]
  end
end
