defmodule Fibsum do
    
    def fiblist(num) do
        case num do
            0 -> [0]
            1 -> [0, 1]
            _ -> fib_step(0, 1, num, [0, 1])
        end
    end

    defp fib_step(a, b, max, list) do
        if a + b > max do
            list
        else
            fib_step(b, a + b, max, list ++ [a + b])
        end
    end
    
    def sum(max) do
        Enum.sum(fiblist(max))
    end
    
    def evensum(max) do
        fiblist(max)
        |> Enum.filter(&(rem(&1, 2)==0))
        |> Enum.sum
    end
end

IO.puts Fibsum.evensum(4000000)
#IO.inspect(Fibsum.fiblist(50))
# Got 4613732