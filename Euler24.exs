# A permutation is an ordered arrangement of objects. For example, 3124 is one
# possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
# are listed numerically or alphabetically, we call it lexicographic order. The
# lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4,
# 5, 6, 7, 8 and 9?

defmodule Euler24 do

  def go do
    list = [0,1,2,3,4,5,6,7,8,9]

    permutations = of(list)
    |> Enum.at(1000000 - 1)
    |> Integer.undigits
  end
  
  def of([]) do
    [[]]
  end

  def of(list) do
    for h <- list, t <- of(list -- [h]), do: [h|t]
  end

  # def go do
  #   list = [0,1,2,3,4,5,6,7,8,9]
  #   lists = for a<-list, b<-list, c<-list, d<-list, e<-list,
  #               f<-list, g<-list, h<-list, i<-list, j<-list do
  #     [a,b,c,d,e,f,g,h,i,j]
  #   end
    
  #   Enum.map(lists, fn x -> Enum.uniq(x) end)
  #   |> Enum.sort
  #   |> Enum.at(1000000)
  #   |> inspect
  # end

  # def shuffle(list, count \\ 1, n \\ 10) do
  #   inspect(list)
    
  #   cond do
  #     count > n -> list
  #     true -> shuffle(list ++ [Enum.shuffle(list)], count+1, n)
  #   end
  # end
end
