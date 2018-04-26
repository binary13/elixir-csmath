defmodule Pal do
  def is_palindrome?(num) do
    Integer.to_string(num) == String.reverse(Integer.to_string((num)))  
  end
  
  def num_digits(digits, diglist \\ 0) do
    if digits < 1 do
      diglist
    else
      num_digits(digits-1, diglist * 10 + 9)
    end
  end
  
  def largest_pal_product(digits) do
    pal_products(num_digits(digits), num_digits(digits), [])
    |> Enum.max
  end
  
  def pal_products(1, 1, list) do
    list
  end

  def pal_products(num1, num2, list) do
    if is_palindrome?(num1 * num2) do
      if num2 > 1 do
        pal_products(num1, num2 - 1, list ++ [num1 * num2])
      else
        pal_products(num1-1, num1-1, list ++ [num1 * num2])
      end
    else
      if num2 > 1 do
        pal_products(num1, num2 - 1, list)
      else
        pal_products(num1-1, num1-1, list)
      end
    end
  end
end

