defmodule ChapterThreeTest do
  use ExUnit.Case
  doctest ChapterThree

  # list_len/1

  test "calculates correct length" do
    assert ChapterThree.list_len([1, 5, 3]) == 3
  end

  assert_raise FunctionClauseError, fn ->
    ChapterThree.list_len(5)
  end

  # range/2

  test "calculates correct range" do
    assert ChapterThree.range(1, 5) == [5, 4, 3, 2, 1]
  end

  assert_raise FunctionClauseError, fn ->
    ChapterThree.range(5, 2)
  end


  assert_raise FunctionClauseError, fn ->
    ChapterThree.range([1], 2)
  end

  # positive/1

  test "calculates correct list" do
    assert ChapterThree.positive([1, 2, 3, 4, 5]) == [4, 2]
  end
end
