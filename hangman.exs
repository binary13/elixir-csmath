defmodule Hangman do
    def enter_word do
        IO.gets("Enter a secret word: ")
        |> String.trim
        |> String.graphemes
    end


    def play() do
        enter_word()
        |> take_guess([], [], 0)
    end

    def print_word(word, guessed) do
        IO.puts(    
            for letter <- word do
                if !Enum.member?(guessed, letter) do
                    "_ "
                else
                    "#{letter} "
                end
            end
        )
    end

    def clear(n\\32) do
        IO.puts "\n"
        if n != 0 do
            clear(n-1)
        end
    end

    def print_man(num_guesses) do
        IO.puts(
            case num_guesses do
                0 -> "   __\n  |  |\n  |\n  |\n  |\n _______\n|       |"
                1 -> "   __\n  |  |\n  |  0\n  |\n  |\n _______\n|       |"
                2 -> "   __\n  |  |\n  |  0\n  |  |\n  |\n _______\n|       |"
                3 -> "   __\n  |  |\n  |  0\n  | /|\n  |\n _______\n|       |"
                4 -> "   __\n  |  |\n  |  0\n  | /|\\\n  |\n _______\n|       |"
                5 -> "   __\n  |  |\n  |  0\n  | /|\\\n  | /\n _______\n|       |"
                6 -> "   __\n  |  |\n  |  0\n  | /|\\\n  | / \\\n _______\n|       |"
            end
        )
    end

    def take_guess(_word, _guessed, _wrong, 6) do
        clear()
        print_man(6)
        IO.puts "Sorry, you are out of guesses!"
        IO.puts "Game over"
    end

    def take_guess(word, guessed, wrong, num_guesses) do
        clear()
        print_man(num_guesses)
        if Enum.sort(Enum.uniq(word)) == Enum.sort(Enum.uniq(guessed)) do
            IO.puts "Congratulations! You got it!"
            print_word(word, guessed)       
        else
            print_word(word, guessed)
            IO.puts "You have #{6-num_guesses} guesses left."
            letter = IO.gets("\nEnter a letter: ")|> String.trim
            if Enum.member?(guessed, letter) or Enum.member?(wrong, letter) do
                IO.puts "You've already guessed that!"
                take_guess(word, guessed, wrong, num_guesses)
            else
                if Enum.member?(word, letter) do
                    take_guess(word, guessed ++ [letter], wrong, num_guesses)
                else
                    take_guess(word, guessed, wrong ++ [letter], num_guesses + 1)
                end
            end
        end
    end
end

Hangman.play