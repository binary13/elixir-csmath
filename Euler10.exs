defmodule Euler10 do

  def is_prime?(num, divisor \\ 2) do
    if divisor <= div(num,2) do
      if rem(num, divisor) == 0 do
        false
      else
        is_prime?(num, divisor + 1)
      end
    else
      true
    end
  end
  
  def gen_sum(acc, step, num) when step >= num do
    acc
  end
  
  def gen_sum(acc, step, num) do
    if is_prime?(step) == true do
      gen_sum(acc + step, step + 1, num)
    else
      gen_sum(acc, step + 1, num)
    end
  end
  
  def sum_of_primes_less_than(num) do
    gen_sum(0, 2, num)
    |> IO.puts
  end
end

Euler10.sum_of_primes_less_than(2000000)