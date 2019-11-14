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
  def word_list do
    contents = File.read!("assets/words.txt")
    String.split(contents)
  end

  def random_word do
    Enum.random(word_list())
  end

  def test do
    IO.puts "Testing! Testing! 1, 2, 3!"
  end
end
