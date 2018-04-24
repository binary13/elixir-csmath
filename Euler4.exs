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
    product(num_digits(digits), num_digits(digits))
  end
  
  def product(num1, num2) do
    if is_palindrome?(num1 * num2) do
      num1 * num2
    else
      if num2 > 1 do
        product(num1, num2 - 1)
      else
        product(num1-1, num1-1)
      end
    end
  end
end

