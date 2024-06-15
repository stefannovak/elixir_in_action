defmodule ChapterThreeTest do
  use ExUnit.Case
  doctest ChapterThree

  test "calculates correct length" do
    assert ChapterThree.list_len([1, 5, 3]) == 3
  end
end
