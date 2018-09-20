defmodule Euler9 do
  def is_triple?({a, b, c}) do
    if (a*a + b*b == c*c), do: true, else: false
  end

  def is_sum?({a, b, c}) do
    if (a+b+c == 1000), do: true, else: false
  end

  def go do
    for a <- 1..1000, b <- a..1000, c <- b..1000, is_triple?({a,b,c}), is_sum?({a,b,c}) do
      {a, b, c}
    end
    |> Enum.map(fn {a,b,c} -> a*b*c end)
    |> Enum.at(0)
    |> IO.puts
  end
end

Euler9.go