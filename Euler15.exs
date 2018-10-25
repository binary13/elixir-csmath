defmodule Euler15 do
  def go(n) do
    div(div(factorial(n*2), factorial(n)), factorial(n))
  end

  def factorial(n, product \\ 1) do
    if n == 1 do 
      product
    else
      factorial(n-1, product*n)
    end
  end





# Brute force method

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
    digits = Integer.digits(num, 2)
    if Enum.count(digits, &(&1 == 1)) == rows do
      digits |> IO.inspect
      true
    else
      false
    end
  end
end