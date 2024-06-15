defmodule ChapterThree do
  @moduledoc """
  Documentation for `ElixirInAction`.
  """

  @doc """
  Calculate the length of a list

  ## Examples

      iex> ChapterThree.list_len([])
      0

      iex> ChapterThree.list_len([1])
      1

      iex> ChapterThree.list_len([1,2,3,4,5,6])
      6
  """
  def list_len(list) when is_list(list) do
    list_len_acc(0, list)
  end

  defp list_len_acc(length, []) do
    length
  end

  defp list_len_acc(length, [_ | tail]) do
    list_len_acc(length + 1, tail)
  end

  @doc """
  Calculate the range between two numbers.
  a must be lower than b, and must be numbers.
  The range returned is reversed.

  ## Examples

    iex> ChapterThree.range(1, 3)
    [3, 2, 1]
  """
  @spec range(number(), number()) :: [number(), ...]
  def range(a, b) when is_number(a) and is_number(b) and a < b do
    range_acc(b, [a])
  end

  defp range_acc(last, accumulator) do
    if hd(accumulator) + 1 == last do
      [last | accumulator]
    else
      range_acc(last, [hd(accumulator) + 1 | accumulator])
    end
  end
end
