defmodule Euler18 do
	def go do
		read_string_from_file("E18t2.txt")
		|> max_sum
	end

	def read_string_from_file(filename) do
		case File.read(filename) do
			{:ok, file} 	 -> process_triangle(String.split(file, "\n", trim: true))
			{:error, reason} -> IO.puts "Error! Reason: #{reason}."
		end
	end

	def process_triangle(lines) do
		for line <- lines do
			String.split(line, " ")
			|> Enum.map(fn x -> String.to_integer(x) end)
		end
		|> Enum.reverse
	end	
	
	def max_sum(data) when length(data) == 1 do
		#IO.inspect(data)
		data
		|> List.flatten
		|> Enum.at(0)
		|> IO.puts
	end

	def max_sum(data) do
		#IO.inspect(data)
		[line, next|top] = data
		pairs = Enum.chunk_every(line, 2, 1, :discard)
		tuples = Enum.zip(pairs, next)
		sums = 
			for tuple <- tuples do
				Enum.max(elem(tuple, 0)) + elem(tuple, 1)
			end
		max_sum([sums|top])
	end
end

Euler18.go