fizz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, n) -> n
end
  
buzz = fn(n) -> fizz.(rem(n,3), rem(n,5), n) end

fizzbuzz = fn(n) ->
  Enum.each(1..n, fn (x) -> buzz.(x) 
    |> IO.puts end)
end

fizzbuzz.(100)