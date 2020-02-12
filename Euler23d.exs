#########################################################
#
#  Modeled after this solution in clojure.
#  Finished in 83.2 seconds.
#  More functional, not as efficient as third attempt.
#
#########################################################
#
# (defn divisors [n]
#   (if (= n 1)
#     []
#     (filter #(= 0 (rem n %)) (range 1 n))))
# 
# (defn is-abundant [n] (< n (reduce + (divisors n))))
# 
# (def abundants (set (filter is-abundant (range 1 28123))))
# 
# (defn is-non-abundant-sum [n]
#   (not-any? #(contains? abundants (- n %)) abundants))
# 
# (defn problem23 [] (reduce + (filter is-non-abundant-sum (range 1 28123))))
#
##########################################################

defmodule Euler23 do
  def divisors(n) do
    if n == 1 do []
    else Enum.filter(1..n, &((rem(n,&1)==0) && &1 != n)) end
  end

  def is_abundant(num) do num < Enum.sum(divisors(num)) end

  def abundants() do Enum.filter(1..20161, &(is_abundant(&1))) end
  
  def is_abundant_sum(list, num) do
    Enum.any?(list, fn (x) -> Enum.member?(list, num-x) end)
  end

  def go do
    abd = abundants()
    
    Enum.filter(1..20161, &(!is_abundant_sum(abd, &1)))
    |> Enum.sum
  end
end