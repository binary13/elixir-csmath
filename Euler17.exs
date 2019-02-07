defmodule Euler17 do
  def go(n) do
    for num <- 1..n do
      count(num)
    end
    |> Enum.sum
  end

  def print(num) do
  	for n <- 1..num do
  		num_to_words(n)
  		|> IO.puts
  	end
  	
  end

  def count(num) do
  	num_to_words(num)
  	|> String.replace(" ", "")
  	|> String.replace("-", "")
  	|> String.graphemes
  	|> Enum.count
  end

  def num_to_words(num) do
  	digits = Integer.digits(num)
  	case length(digits) do
  		1 -> digit_to_word(Enum.at(digits,0))
  		2 -> two_digits_to_word(digits)
  		3 -> three_digits_to_word(digits)
  		4 -> four_digits_to_word(digits)
  		_ -> "Out of range."
  	end
  end

  def two_digits_to_word(num) do
  	[h|t] = num
  	if Enum.at(num, 0) == 1 do
  		case num do
  		[1,0] -> "ten"
  		[1,1] -> "eleven"
  		[1,2] -> "twelve"
  		[1,3] -> "thirteen"
  		[1,5] -> "fifteen"
  		[1,8] -> "eighteen"
  		_ -> digit_to_word(Enum.at(t,0)) <> "teen"
  		end
  	else
  		case Enum.at(num, 0) do
  			0 -> ""
  			2 -> "twenty-"
  			3 -> "thirty-"
  			4 -> "forty-"
  			5 -> "fifty-"
  			8 -> "eighty-"
  			_ -> digit_to_word(h) <> "ty-"
  		end
  		<> digit_to_word(Enum.at(t,0))
  	end
  	|> String.trim("-")
  end

  def three_digits_to_word(num) do
  	[h|rest] = num
  	case Enum.at(num, 0) do
  		0 -> if two_digits_to_word(rest) == "", do: "", else: "and "
  		_ -> if two_digits_to_word(rest) == "", do: digit_to_word(h) <> " hundred", else: digit_to_word(h) <> " hundred and "
  	end
  	<> two_digits_to_word(rest)
  end

  def four_digits_to_word(num) do
  	[h|rest] = num
  	case Enum.at(num, 0) do
  		0 -> ""
  		_ -> digit_to_word(h) <> " thousand "
  	end
  	<> three_digits_to_word(rest)
  end

  def digit_to_word(digit) do
  	case digit do
  		1 -> "one"
  		2 -> "two"
  		3 -> "three"
  		4 -> "four"
  		5 -> "five"
  		6 -> "six"
  		7 -> "seven"
  		8 -> "eight"
  		9 -> "nine"
  		_ -> ""
  	end
  end
end