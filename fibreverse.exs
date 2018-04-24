defmodule FibReverse do
    
    def fib(num) do
        case num do
            0 -> 0
            1 -> 1
            _ -> fib_step(0, 1, 2, num)
        end
    end

    defp fib_step(a, b, step, last) do
        if step == last do
            a + b
        else
            fib_step(b, a+b, step+1, last)
        end
    end
end

IO.puts(FibReverse.fib(40))