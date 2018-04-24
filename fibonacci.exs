defmodule Fibonacci do
    def fib(num) do
        case num do
            0 -> 0
            1 -> 1
            _ -> fib(num-1) + fib(num-2)
        end
    end
end

IO.puts(Fibonacci.fib(40))