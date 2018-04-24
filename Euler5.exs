defmodule Divisible do
  
  def by(num, divsr) do
    rem(num, divsr) == 0
  end
  
  def by_range(num, lower, upper) do
    if Enum.map(lower..upper, fn n -> by(num, n) end)
    |> Enum.find(fn bool -> bool == false end) == nil do
      true
    else
      false
    end
  end
    
  def smallest_product(num\\1, lower, upper) do
    if by_range(num, lower, upper) == true do
      num
    else
      smallest_product(num + 1, lower, upper)
    end
  end
end 