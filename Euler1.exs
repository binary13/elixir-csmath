1..1000
|>Enum.filter(fn(n) -> rem(n,3)==0 or rem(n,5)==0 end)
|>Enum.sum
|>IO.puts