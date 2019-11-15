defmodule Dictionary do
  @moduledoc """
  Documentation for Dictionary.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Dictionary.hello()
      :world

  """
  def hello do
    :world
  end

  def word_list do
    "assets/words.txt"
    |> File.read!
    |> String.split
  end

  def random_word do
    word_list()
    |> Enum.random
  end

  def test do
    IO.puts "Testing! Testing! 1, 2, 3!"
  end
end
