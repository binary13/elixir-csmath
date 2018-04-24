defmodule Euler6 do

  def sum_of_squares(a\\1, b) do
    a..b
    |> Enum.map(fn n -> n*n end)
    |> Enum.sum
  end
  
  def square_of_sums(a\\1, b) do
    apply(&(&1*&1), [a..b |> Enum.sum])
  end
  
  def diff(a\\1, b) do
    abs(square_of_sums(a,b) - sum_of_squares(a,b))
  end
end

IO.puts Euler6.diff(10)
IO.puts Euler6.diff(100)