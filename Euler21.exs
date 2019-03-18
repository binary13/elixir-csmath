###############################################################################
#																																							#
#	 Euler Problem 21																														#	
#																																							#
###############################################################################
#
#	 Let d(n) be defined as the sum of proper divisors of n (numbers less than n 
#  which divide evenly into n). If d(a) = b and d(b) = a, where a ≠ b, then a 
#  and b are an amicable pair and each of a and b are called amicable numbers.
#
#	 For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 
#  55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 
#	 71 and 142; so d(284) = 220.
#
#	 Evaluate the sum of all the amicable numbers under 10000.
#
###############################################################################

defmodule Euler21 do
	def factor(num) do
		find_factors(num)
	end

	defp find_factors(num, divisor \\ 1, factors \\ [])

	defp find_factors(num, divisor, factors) when divisor >= num do
		factors
	end

	defp find_factors(num, divisor, factors) do
		if rem(num, divisor) == 0 do
		  find_factors(num, divisor+1, factors ++ [divisor])
		else
		  find_factors(num, divisor+1, factors)
		end
	end

	def d(num) do
		factor(num)
		|> Enum.sum
	end

	def is_amiable?(num) do
		if d(d(num)) == num && d(num) != num do
			true
		else
			false
		end
	end

	def amiable_list(num) do
		for n <- 1..num, is_amiable?(n), do: n
	end

	def go(num) do
		amiable_list(num)
		|> Enum.sum
	end
end