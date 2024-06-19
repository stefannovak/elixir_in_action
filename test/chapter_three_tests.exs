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

  # large_lines!/1

  test "calculates the correct list of numbers" do
    assert ChapterThree.large_lines!(".formatter.exs") == [22, 1, 67, 1]
  end

  # large_lines_length!/1

  test "calculates the largest line of a given file" do
    assert ChapterThree.large_lines_length!(".formatter.exs") == 67
  end

  # longest_line!/1

  test "returns the longest line of a given file" do
    assert ChapterThree.longest_line!(".formatter.exs") == "  inputs: [\"{mix,.formatter}.exs\", \"{config,lib,test}/**/*.{ex,exs}\"]\n"
  end

  # words_per_line!/1

  test "returns the correct list of a word count per line" do
    assert ChapterThree.words_per_line!(".formatter.exs") == [5, 1, 3, 1]
  end

end
