defmodule Euler4 do
    def palindrome(num) do
        if Enum.reverse(Integer.digits(num)) == Integer.digits(num) do
            true
        else
            false
        end
    end

    def product do
        for a <- 100..999, b <- 100..999 do
            a*b
        end
        |> Enum.filter(&palindrome/1)
        |> Enum.max
    end
end

IO.puts(Euler4.product)