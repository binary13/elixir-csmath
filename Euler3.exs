defmodule Prime do
  def is_prime?(1) do
    false
  end
  
  def is_prime?(num, divisor \\ 2) do
    if divisor < div(num,2) do
      if rem(num, divisor) == 0 do
        false
      else
        is_prime?(num, divisor + 1)
      end
    else
      true
    end
  end
  
  def factor(num) do
    find_factors(num)
  end
  
  defp find_factors(num, divisor \\ 1, factors \\ [])
  
  defp find_factors(num, divisor, factors) when divisor > num do
    factors
  end
  
  defp find_factors(num, divisor, factors) do
    if rem(num, divisor) == 0 do
      find_factors(num, divisor+1, factors ++ [divisor])
    else
      find_factors(num, divisor+1, factors)
    end
  end
  
  def prime_factors(num) do
    factor(num)
    |> Enum.filter(&is_prime?/1)
  end
  
  def max_prime_factor_SLOW(num) do
    prime_factors(num)
    |> Enum.max
  end
  
  def max_prime_factor(num, divisor \\ 2)
  
  def max_prime_factor(num, divisor) when divisor >= num/2 do
    num
  end
  
  def max_prime_factor(num, divisor) do
    if rem(num, divisor) == 0 and is_prime?(div(num, divisor)) do
      div(num, divisor)
    else
      max_prime_factor(num, divisor + 1)
    end
  end
end

IO.puts Prime.max_prime_factor(600_851_475_143)
# Expect