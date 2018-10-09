defmodule Euler15 do
  def go(n) do
    #matrix_recursive(0, ((:math.pow(2, n)|> round)-1), n)
    matrix(n)
  end

  def matrix(n) do
    my_filter = fn (num) -> filter(num, n) end 
    for num <- round(:math.pow(2, n)-1)..round(:math.pow(2, 2*n)-1), my_filter.(num) do
      num
    end
    |> Enum.count
  end

  def matrix_recursive(count, num, rows) do
    cond do
      num == :math.pow(2, 2*rows) |> round -> count
      !filter(num, rows) -> matrix_recursive(count, num+1, rows)
      true -> matrix_recursive(count+1, num+1, rows)
    end
  end

  def filter(num, rows) do
    if Enum.count(Integer.digits(num,2), &(&1 == 1)) == rows do
      Integer.digits(num, 2) |> IO.inspect
      true
    else
      false
    end
  end
end