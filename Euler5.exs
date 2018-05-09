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

#Divisible.smallest_product(1,10) |> IO.puts # Expect 2520
#Divisible.smallest_product(1,20) |> IO.puts # Produces 232792560

# Eamon Payton's version - produces a number much too large
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
Euler5_alt.final(99)
