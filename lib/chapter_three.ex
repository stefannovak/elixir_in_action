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

  @doc """
  Returns the reverse ordered, positive elements of a given integer list.

  ## Examples

    iex> ChapterThree.positive([1, 2, 6, 3, 8, 10])
    [10, 8, 6, 2]
  """
  @spec positive([integer()]) :: [integer()]
  def positive(list) when is_list(list) do
    positive_acc(list, [])
  end

  defp positive_acc([], acc) do
    acc
  end

  defp positive_acc([head | tail], acc) do
    if rem(head, 2) == 0 do
      positive_acc(tail, [head | acc])
    else
      positive_acc(tail, acc)
    end
  end

  @doc """
  Read a file and return a list of numbers representing the length
  of the corresponding line.

  ## Examples

    iex> ChapterThree.large_lines!(".gitignore")
    [53, 8, 0, 61, 7, 0, 59, 6, 0, 66, 5, 0, 73, 7, 0, 62, 14, 0, 64, 4, 0, 53, 22, 0, 43, 5]
  """
  def large_lines!(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.length(&1))
  end

  @doc """
  Read a file and length of the longest line.

  ## Examples

    iex> ChapterThree.large_lines_length!(".gitignore")
    73
  """
  def large_lines_length!(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.length(&1))
    |> Enum.max()
  end

  @doc ~S"""
  Return the contents of the longest line in a file.

  ## Examples
    iex> ChapterThree.longest_line!(".gitignore")
    "# Ignore .fetch files in case you like to edit your project deps locally.\n"
  """
  def longest_line!(path) do
    File.stream!(path) |> Enum.max_by(&String.length/1)
  end

  @doc """
  Return a list of numbers with each number representing the word count in a file

  ## Examples
    iex> ChapterThree.words_per_line!(".gitignore")
    [9, 1, 0, 12, 1, 0, 9, 1, 0, 9, 1, 0, 14, 1, 0, 13, 1, 0, 9, 1, 0, 8, 1, 0, 7, 1]
  """
  def words_per_line!(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x) |> length() end)
  end
end
