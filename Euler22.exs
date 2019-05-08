###############################################################################
#																			  #
#						Project Euler Problem 22							  #
#																			  #
###############################################################################
#
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file 
# containing over five-thousand first names, begin by sorting it into alphabet-
# ical order. Then working out the alphabetical value for each name, multiply 
# this value by its alphabetical position in the list to obtain a name score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which is 
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN 
# would obtain a score of 938 × 53 = 49714.
#
# What is the total of all the name scores in the file?
#
###############################################################################

defmodule Euler22 do

	def go do
		read_file("names.txt")
		|> split
		|> Enum.sort
		|> calc_scores
		|> Enum.sum
	end

	def read_file(input_file) do
		case File.read(input_file) do
			{:ok, file} 	 -> file
			{:error, reason} -> IO.puts "Error! Reason: #{reason}."
		end
	end

	def split(file) do
		String.replace(file, "\"", "")
		|> String.split(",", trim: true)
	end

	def calc_scores(names) do
		name_tuples = Enum.zip(1..length(names), names)
		for {place, name} <- name_tuples do
			place * name_score(name)
		end
	end

	def name_score(name) do
		for char <- String.graphemes(name) do
			letter_score(char)
		end
		|> Enum.sum
	end

	def letter_score(letter) do
		alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		[head | _tail] = String.split(alphabet, letter)
		String.length(head) + 1
	end
	
end