defmodule Euler17 do
  def go(n) do
    for num <- 1..n do
      num_to_words(num)
    end
    |> Enum.join
    |> Enum.count
  end
end