###########################################################
#														  #
#                 Problem Description                     #
#														  #
###########################################################
#
#
# 	n! means n × (n − 1) × ... × 3 × 2 × 1
#
# 	For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# 	and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# 	Find the sum of the digits in the number 100!
#
#
###########################################################

defmodule Euler20 do
	def factorial(num) do
		Enum.reduce(1..num, 1, fn x, acc -> x * acc end)
	end

	def digits(num) do
		num |> Integer.digits
	end

	def sum_fact(num) do
		num
		|> factorial
		|> digits
		|> Enum.sum
	end
end