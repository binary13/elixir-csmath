defmodule Euler14 do
  def go(max) do
    {start, _} =
      for starting_number <- 1..max do
        {starting_number, seq_count(starting_number)}
      end
      |> Enum.max_by(fn {_x, i} -> i end)

    start
  end

  def seq_count(term, count\\1) do
    if term == 1 do
      count
    else 
      if rem(term,2) == 0 do
        seq_count(div(term,2), count+1)
      else
        seq_count(3*term+1, count+1)
      end
    end
  end
end

