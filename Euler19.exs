# You are given the following information, but you may prefer to do some research for yourself.

# 	1 Jan 1900 was a Monday.
# 	Thirty days has September,
# 	April, June and November.
# 	All the rest have thirty-one,
# 	Saving February alone,
# 	Which has twenty-eight, rain or shine.
# 	And on leap years, twenty-nine.

# A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

defmodule Euler19 do

	def days_of_the_week, do: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
	def	months, do: ["January", "February", "March", "April", "May", "June", 
					 "July", "August", "September", "November", "December"]
	def days_in_month, do: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	def start_date, do: ["Monday", "January", 1, 1900]
	
	def build_month([day, month, 1, year]) do
		first_day_index = Enum.find_index(days_of_the_week, fn x -> x == day end)
		num_days = Enum.at(days_in_month, Enum.find_index(months, fn x -> x == month end))

		for num <- 1..num_days do
			[Enum.at(days_of_the_week, rem(num+first_day_index, 7)-1), month, num, year]
		end
	end

	def build_month([day, "February", 1, year]) do
		
	end

	def next(list) do
		[lday, lmonth, ldate, lyear] = Enum.last(list)
		lday_index = Enum.find_index(days_of_the_week, fn x -> x == lday end)
		lmonth_index = Enum.find_index(months, fn x -> x == lmonth end)

		[Enum.at(days_of_the_week, rem(lday_index+1, 7)), Enum.at(months, rem(lmonth_index+1, 12)), 1, lyear]
	end

	def build([day, month, 1, year], list, end_year) do
		if year == end_year do
			list
		else
			build_year(next(list), list, end_year)
		end
	end

	def build_year([day, month, 1, year]) do
		
	end
	
end