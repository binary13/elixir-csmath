###############################################################################
#
# Euler 23
#
###############################################################################

# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors of 28
# would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

# A number n is called deficient if the sum of its proper divisors is less than n
# and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123 can
# be written as the sum of two abundant numbers. However, this upper limit cannot
# be reduced any further by analysis even though it is known that the greatest
# number that cannot be expressed as the sum of two abundant numbers is less than
# this limit.

# Find the sum of all the positive integers which cannot be written as the sum of
# two abundant numbers.

defmodule Euler23 do

	def go(n \\ 28123) do
		sum = generate_abundant_numbers(n)
		|> sums_of_abundant_numbers
		|> filter_abundant_sums(n)
		|> Enum.sum

		IO.puts("\n")
		IO.puts(String.duplicate("*", 40))
		IO.puts("Final sum: ")
		IO.puts(String.duplicate("*", 40))
	end

	# Generates a list of abundant numbers less than a given limit
	def generate_abundant_numbers(num \\ 12, list \\ [], limit) do
		cond do
			num > limit ->
				IO.puts(String.duplicate("*", 40))
				IO.puts("Finished finding abundant numbers less than " <> Integer.to_string(limit))
				IO.puts(String.duplicate("*", 40))
				list
			is_abundant?(num) ->
				IO.puts(num)
				generate_abundant_numbers(num + 1, list ++ [num], limit)
			true -> generate_abundant_numbers(num + 1, list, limit)
		end
	end

	def sums_of_abundant_numbers(list) do
		list2 = for a <- list, b <- list do
			a + b
			IO.puts(a + b)
		end
		|> Enum.uniq()
		IO.puts(String.duplicate("*", 40))
		IO.puts "Finished finding sums of abundant numbers"
		IO.puts(String.duplicate("*", 40))
		list2
	end

	def filter_abundant_sums(list, n) do
		Enum.filter(1..n, &(Enum.member?(list, &1)))
	end

	def is_abundant?(num) do
		num < sum_prop_divisors(num)
	end



	# Determines if a given number can be written as the sum of a pair of given
	# numbers.
	# Parameters:
	# 	num: the number in question
	# 	nums: a list of numbers to test
	def is_sum_of_nums?(num, nums) do
		for a <- nums, b <- nums do a+b end
		|> Enum.any?(&(&1==num))
	end

	def sum_prop_divisors(num) do
		divisors(num)
		|> Enum.sum
	end

	def divisors(num) do
	    find_factors(num)
	end

	defp find_factors(num, divisor \\ 1, factors \\ [])

	defp find_factors(num, divisor, factors) when divisor > num/2 do
	    Enum.sort(factors)
	end

	defp find_factors(num, divisor, factors) do
	    if rem(num, divisor) == 0 do
	      find_factors(num, divisor+1, factors ++ [divisor])
	    else
	      find_factors(num, divisor+1, factors)
	    end
	end

	# def filter_nonsum_ints(list) do

	# end
end
