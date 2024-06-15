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
  def list_len(list) do
    list_len_acc(0, list)
  end

  defp list_len_acc(length, []) do
    length
  end

  defp list_len_acc(length, [_ | tail]) do
    list_len_acc(length + 1, tail)
  end
end
