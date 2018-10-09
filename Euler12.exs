defmodule Euler12 do
  def trinum(0), do: 0
  def trinum(n), do: n + trinum(n-1)
  def trilist(n) do
    for num <- 1..n do
      trinum(num)
    end
  end

  def factor(num) do
    find_factors(num)
  end
  
  defp find_factors(num, divisor \\ 1, factors \\ [])
  
  defp find_factors(num, divisor, factors) when divisor > num/2 do
    Enum.sort(factors)
  end
  
  defp find_factors(num, divisor, factors) do
    if rem(num, divisor) == 0 do
      find_factors(num, divisor+1, factors ++ [divisor] ++ [num/divisor])
    else
      find_factors(num, divisor+1, factors)
    end
  end

  def divprint(count \\ 1, acc \\ 0,  min_factors) do
    num = acc + count
    factors = factor(num)
    IO.puts("#{num}: #{Enum.join(factors, ", ")}")
    if Enum.count(factors) <= min_factors do
      divprint(count + 1, num, min_factors)
    end
  end
end