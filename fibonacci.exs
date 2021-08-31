defmodule Fibonacci do
    def fib_recursive(num) do
        case num do
            0 -> 0
            1 -> 1
            _ -> fib_recursive(num-1) + fib_recursive(num-2)
        end
    end

    def fib_iterative(0), do: 0
    def fib_iterative(1), do: 1
    def fib_iterative(n) when n > 1 do
        compute_seq(n, 1, [0, 1])
    end

    defp compute_seq(n, i, acc) when n == i do
        Enum.at(acc, length(acc)-1)
    end

    defp compute_seq(n, i, acc) do
        len = length(acc)
        compute_seq(n, i+1, acc ++ [Enum.at(acc, len - 1) + Enum.at(acc, len-2)])
    end
end
