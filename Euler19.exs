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

	###############################################
	#                  CONSTANTS				  #
	###############################################
	def days_of_the_week, do: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	def	months, do: ["January", "February", "March", "April", "May", "June", 
					 "July", "August", "September", "October", "November", "December"]
	def days_in_month, do: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	def start_date, do: ["Monday", "January", 1, 1900]
	###############################################


	def go do
		count(2000) - count(1900)
	end

	def count(end_year) do
		build([], start_date(), end_year)
		|> Enum.filter(fn [x, _, y, _] -> x == "Sunday" && y == 1 end)
		|> Enum.count
	end

	def build(list, day, end_year) do
		[_lday, _lmonth, _ldate, lyear] = day
		if lyear > end_year do
			list
		else
			build(list ++ [day], next(day), end_year)
		end
	end


	def next([lday, lmonth, ldate, lyear]) do
		lday_index = Enum.find_index(days_of_the_week(), fn x -> x == lday end)
		lmonth_index = Enum.find_index(months(), fn x -> x == lmonth end)
		
		days = 
			if lmonth == "February" do
				if rem(lyear, 4) == 0 do
					if rem(lyear, 100) == 0 do
						if rem(lyear, 400) == 0 do
							29
						else
							28
						end
					else
						29
					end
				else
					28
				end
			else
				Enum.at(days_in_month(), lmonth_index)
			end

		if ldate >= days do
			if lmonth == "December" do
				[Enum.at(days_of_the_week(), rem(lday_index+1, 7)), Enum.at(months(), rem(lmonth_index+1, 12)), 
					1, lyear + 1]
			else
				[Enum.at(days_of_the_week(), rem(lday_index+1, 7)), Enum.at(months(), rem(lmonth_index+1, 12)), 
					1, lyear]
			end
		else
			[Enum.at(days_of_the_week(), rem(lday_index+1, 7)), lmonth, ldate + 1, lyear]
		end
	end

end