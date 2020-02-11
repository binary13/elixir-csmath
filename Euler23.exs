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

	###########################################################
	#
	#  Third attempt following Euler23.py. Should be very fast.
	#  Kind of a mix of the two methods.
	#  Finished in 46 seconds.
	#
	###########################################################

	def sum(count \\ 1, limit \\ 20161, list \\ [], acc \\ 0) do
		cond do
			count > limit ->
				acc
			is_abundant?(count) && !is_sum?(count, list) ->
				sum(count+1, limit, [count | list], acc+count)
			is_abundant?(count) ->
				sum(count+1, limit, [count | list], acc)
			!is_sum?(count, list) ->
				sum(count+1, limit, list, acc+count)
			true ->
				sum(count+1, limit, list, acc)
		end
	end

	def is_perfect_square?(num) do
		trunc(:math.sqrt(num)) == :math.sqrt(num)
	end

	def is_abundant?(num) do
		num < sum_prop_divisors(num)
	end

	def sum_prop_divisors(num, count \\ 2, acc \\ 1) do
		cond do
			count > :math.sqrt(num) -> trunc(acc)
			rem(num, count) == 0 && count == num/count -> sum_prop_divisors(num, count+1, acc + count)
			rem(num, count) == 0 -> sum_prop_divisors(num, count+1, acc + count + num/count)
			true -> sum_prop_divisors(num, count+1, acc)
		end
	end

	# Determines if a given number can be written as the sum of
	# two elements of a list.
	def is_sum?(num, nums) do
		check_sum(num, nums, 0)
	end

	def check_sum(num, nums, count \\ 0) do
		cond do
			count >= length(nums) ->
				false
			(num - Enum.at(nums, count)) in nums ->
				true
			true ->
				check_sum(num, nums, count+1)
		end
	end




	##################################################
	#
	# Second attempt. Much faster, still inefficient.
	#
	##################################################
	def go2(n \\ 20161) do
		total = non_abundant_sums(1, 0, n)
		IO.puts("Total = #{total}")
	end

	def non_abundant_sums(num, acc, limit) do
		if num > limit do
			acc
		else
			if is_sum_of_abundant?(num) do
				IO.puts("Abundant sum found: #{num}. Total: #{acc+num}")
				non_abundant_sums(num+1, acc, limit)
			else
				#IO.puts("Non-abundant sum found: #{num}. Running total: #{acc+num}.")
				non_abundant_sums(num+1, acc + num, limit)
			end
		end
	end

	def is_sum_of_abundant?(num, count \\ 12) do
		cond do
			count > num/2 -> false
			is_abundant2?(count) && is_abundant2?(num-count) -> true
			true -> is_sum_of_abundant?(num, count+1)
		end
	end

	def is_abundant2?(num) do
		num < sum_prop_divisors2(num)
	end

	def sum_prop_divisors2(num) do
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




#######################################################
#
# First attempt. Too slow.
#
#######################################################


	def go1(n \\ 28123) do
		sum = generate_abundant_numbers(n)
		|> sums_of_abundant_numbers
		|> filter_abundant_sums(n)
		|> Enum.sum

		IO.puts("\n")
		IO.puts(String.duplicate("*", 40))
		IO.puts("Final sum: #{sum}")
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
			IO.puts(a + b)
			a + b
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
end
