defmodule Chop do
  defp midpoint(a, b) do
    div(a+b, 2)
  end

  def guess(n, a..b) do
    guess_helper(midpoint(a, b), n, a..b) 
  end

  defp guess_helper(_, n, a..b) when n > b or n < a do
    IO.puts "Number out of range!"
  end

  defp guess_helper(g, n , _.._) when g == n do
    IO.puts "Found it!"
    IO.puts "The number is #{g}!"
  end
  
  defp guess_helper(g, n , a.._) when n < g do
    IO.puts "Is the number #{g}?"
    guess_helper(midpoint(a, g), n, a..g)
  end

  defp guess_helper(g, n, _..b) when n > g do
    IO.puts "Is the number #{g}?"
    if g == midpoint(g, b) do
      guess_helper(g+1, n, g..b)
    else
      guess_helper(midpoint(g, b), n, g..b)
    end
  end
end

