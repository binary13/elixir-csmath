# The Fibonacci sequence is defined by the recurrence relation:

# Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.
# Hence the first 12 terms will be:

# F1 = 1
# F2 = 1
# F3 = 2
# F4 = 3
# F5 = 5
# F6 = 8
# F7 = 13
# F8 = 21
# F9 = 34
# F10 = 55
# F11 = 89
# F12 = 144
# The 12th term, F12, is the first term to contain three digits.

# What is the index of the first term in the Fibonacci sequence to
# contain 1000 digits?

defmodule Euler25 do
    def seq(0), do: 0
    def seq(1), do: 1
    def seq(n) when n > 1 do
        compute_seq(n, 1, [0, 1])
    end

    defp compute_seq(n, i, acc) when n == i do
        Enum.at(acc, length(acc)-1)
    end

    defp compute_seq(n, i, acc) do
        len = length(acc)
        compute_seq(n, i+1, acc ++ [Enum.at(acc, len - 1) + Enum.at(acc, len-2)])
    end

    def fib_digits(num \\ 0) do
        seq(num)
        |> Integer.digits()
        |> length()
    end

    def thousand(num \\ 0) do
        if fib_digits(num) == 1000 do
            num
        else
            thousand(num+1)
        end
    end
end
