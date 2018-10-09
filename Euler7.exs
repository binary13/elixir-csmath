defmodule Prime do

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
  
  def generate_list(num) do
    gen_list([], 2, num)
  end
  
  def gen_list(primes_list, _step, num) when length(primes_list) == num do
    primes_list
  end
  
  def gen_list(primes_list, step, num) do
    if is_prime?(step) == true do
      gen_list(primes_list ++ [step], step + 1, num)
    else
      gen_list(primes_list, step + 1, num)
    end
  end
  
  def generate_nth(num) do
    generate_list(num)
    |> List.last
    |> IO.puts
  end
end
    
Prime.generate_nth(10001)  