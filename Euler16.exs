defmodule Euler16 do
  def go(n) do
    :math.pow(2, n) |> round |> Integer.digits |> Enum.sum
  end
end