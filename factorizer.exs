defmodule Fact do
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

  def find(num) do
    find_factors(num, 2, [])       
  end

  def find_factors(1, _divisor, list) do
    list
  end

  def find_factors(num, divisor, list) do
    if rem(num, divisor) == 0 and is_prime?(divisor) do
      find_factors(div(num, divisor), divisor, list ++ [divisor])
    else
      find_factors(num, divisor+1, list)
    end
  end
end