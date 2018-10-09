#Brute force - very slow but works
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
      smallest_product(num + upper, lower, upper)
    end
  end
end 

#Divisible.smallest_product(1,10) |> IO.puts # Expect 2520
#Divisible.smallest_product(1,20) |> IO.puts # Produces 232792560


# Factor-first version - much faster
defmodule Euler5 do
  
  # Single-argument starting point for find_factors
  def factor(num) do
    find_factors(num, 2, [])       
  end

  # End point for recursive function find_factors
  def find_factors(1, _divisor, list) do
    list
  end

  # Finds list of prime factors of a number
  def find_factors(num, divisor, list) do
    if rem(num, divisor) == 0 do
      find_factors(div(num, divisor), divisor, list ++ [divisor])
    else
      find_factors(num, divisor+1, list)
    end
  end

  # Finds a list of lists of prime factors of a range from 2 to num
  def factor_range(num) do
    for x <- 2..num do
      factor x
    end
  end

  # Determine the number of an element in a list
  def count(list, element) do
    Enum.count(list, fn x -> x == element end)
  end

  # Determine greatest number of an element in a list of lists
  # Example: max_power([[2,2,2], [2,2,3]], 2) ==> 3
  def max_power(list_of_lists, element) do
    for list <- list_of_lists do
      count(list, element)
    end
    |> Enum.max
  end

  # Determine greatest number of a list of elements in a list of lists
  # Example: factor_powers([[2,2,2], [2,2,3]], [2,3]) ==> [3, 1]
  def factor_powers(list_of_lists, list_of_factors) do
    for factor <- list_of_factors do
      max_power(list_of_lists, factor)
    end
  end

  # Zip factors and powers into a list of tuples
  def zip(list_of_factors, list_of_powers) do
    Enum.zip(list_of_factors, list_of_powers)
  end

  # Raise each factor to the appropriate power
  def apply_powers(list_of_tuples) do
    pow_list = fn {a, b} -> :math.pow(a, b) end
    Enum.map(list_of_tuples, fn x -> pow_list.(x) end)
  end

  # Multiply a list of values
  def multiply(list) do
    Enum.reduce(list, fn (x, acc) -> x*acc end)
  end

  # Find the smallest number divisible by all numbers in range 2..num
  def smallest_div_num(num) do
    list_of_lists = factor_range(num)
    list_of_factors = list_of_lists |> List.flatten |> Enum.uniq
    list_of_powers = factor_powers(list_of_lists, list_of_factors)

    zip(list_of_factors, list_of_powers)
    |> apply_powers
    |> multiply
    |> Kernel.trunc   
  end

  def go(num) do
    IO.puts smallest_div_num(num)
  end
end



##################################################
# Eamonn Payton's version - fast but complicated #
##################################################
defmodule Euler5_alt do
    def prime(n, m, l) when m < div(n, 2) do
        cond do
            rem(n, m) == 0 ->
                prime(div(n, m), m, l ++ [m])
            true -> prime(n, m + 1, l)
        end
    end
    def prime(4, _, l) do
        l ++ [2,2]
    end
    def prime(n, m, l) when m >= div(n, 2) and n != 4 do
        l ++ [n]
    end
    def mult(x) do #finds prime factorization
        prime(x, 2, [])
    end
    def factors(x) do #finds prime factorization of all numbers range 1..n
        for n <- 1..x do
            mult(n)
        end
    end
    def combine(x) do #combines factors(x) into one list
        Enum.reduce(factors(x), &(&1 ++ &2))
    end
    def count(string, char) do #counts instances of duplicates of char in list
        string 
        |> Enum.map(fn(n) -> if n == char,do: 1, else: 0 end) 
        |> Enum.reduce(0, fn(n, acc) -> n+acc end)
    end
    def check(big, n, list) when big == n do # end of check function
        list
    end
    def check(big, n, list) when big > n and n != 4 do #finds missing factors of factors(x) in Enum.uniq(combine(x))
        list1 =
            for factor <- Enum.uniq(mult(n)) do
                cond do
                    count(mult(n), factor) > count(list, factor) ->
                        for _ <- 1..(count(mult(n), factor) - count(list, factor)) do
                            factor
                        end
                    true -> [1]
                end
            end
        check(big, n + 1, list ++ Enum.at(list1, 0))
    end
        
    def check(big, 4, _) do #start of check function
        list_uniq = Enum.uniq(combine(big))
            
        list1 =
            for factor <- Enum.uniq(mult(4)) do
                cond do
                    count(mult(4), factor) > count(list_uniq, factor) ->
                        for _ <- 1..(count(mult(4), factor) - count(list_uniq, factor)) do
                            factor
                        end
                    true -> 1
                end
            end
        check(big, 4 + 1, list_uniq ++ Enum.at(list1, 0))
    end
    def check_begin(x) do #simpler check function call
        check(x, 4, [])
    end
    def final(x) do #prints product of factors in check(x)
        IO.puts("Euler 5: #{Enum.reduce(check_begin(x), &(&1*&2))}")
    end
end
#Euler5_alt.final(99)

Euler5.go(20)
