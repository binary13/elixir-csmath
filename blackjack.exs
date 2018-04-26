defmodule Blackjack do

  def clear(n\\32) do
    IO.puts "\n\n"
    if n != 0 do
      clear(n-1)
    end
  end
    
  def generate_deck do
    suits = ["Spades", "Hearts", "Clubs", "Diamonds"]
    values = ["Ace", "King", "Queen", "Jack"] ++ Enum.to_list(10..2)
    
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end
  
  def deal(deck, size \\ 2) do
    Enum.split(deck, size)
  end
  
  def print_hand(hand) do
    Enum.join(hand, ", ")
  end
  
  def get_value(hand) do
    values = Enum.map(hand, fn x -> String.split(x) end)
    |> Enum.map(fn x -> Enum.at(x, 0) end)
    
    card_values = for value <- values do
      cond do
        Integer.parse(value) != :error -> {num, _} = Integer.parse(value)
                                          num
        value == "King" -> 10
        value == "Queen" -> 10
        value == "Jack" -> 10
        value == "Ace" -> 1
      end
    end
    
    if Enum.member?(card_values, 1) do
      if Enum.sum(card_values) <= 11 do
        Enum.sum(List.delete(card_values, 1) ++ [11])
      else
        Enum.sum(card_values)
      end
    else
      Enum.sum(card_values)
    end
  end
  
  def blackjack?(hand) do
    if length(hand) == 2 && get_value(hand) == 21 do
      true
    else
      false
    end
  end
  
  def play do
    clear()
    IO.puts("*** Let's play Blackjack! ***")
    deck = generate_deck() |> Enum.shuffle
    
    IO.puts "Dealing..."
    {player_hand, rest} = deal(deck)
    
    if blackjack?(player_hand) do
      IO.puts "You got a blackjack! You had good luck!"
      IO.puts "Your hand was: #{print_hand(player_hand)}"
      play_again?()
    else
      {dealer_hand, rest} = deal(rest)
      if blackjack?(dealer_hand) do
        IO.puts "Dealer got a blackjack! Too bad!"
        IO.puts "Dealer's hand was: #{print_hand(dealer_hand)}"
        play_again?()
      else  
        {_hole_card, shown_card} = Enum.split(dealer_hand, 1)
        IO.puts("Dealer's up card: #{print_hand(shown_card)}")
        player_turn(rest, player_hand, dealer_hand)
      end
    end
  end
  
  def player_turn(deck, player_hand, dealer_hand) do
    IO.puts("Your hand: #{player_hand |> print_hand}")
    decision = IO.gets("Do you want to [h]it or [s]tand? ") |> String.trim
    
    if Enum.member?(["H", "h", "hit"], decision) == true do
      hit(deck, player_hand, dealer_hand)
    else
      IO.puts "Dealer's turn..."
      dealer_turn(deck, player_hand, dealer_hand)
    end    
  end
  
  def hit(deck, player_hand, dealer_hand) do
    {new, rest} = deal(deck, 1)
    IO.puts "You draw #{new}"
    if get_value(player_hand ++ new) > 21 do
      IO.puts "You busted!"
      IO.puts "Your hand was: #{print_hand(player_hand ++ new)}"
      IO.puts "Dealer's hand was: #{dealer_hand |> print_hand}"
      play_again?()
    else
      player_turn(rest, player_hand ++ new, dealer_hand)
    end
  end    

  def dealer_turn(deck, player_hand, dealer_hand) do
    IO.puts("Dealer's hand: #{print_hand(dealer_hand)}")
    if get_value(dealer_hand) < 17 do
      dealer_hit(deck, player_hand, dealer_hand)
    else
      IO.puts "Dealer stands."
      IO.puts "Time to determine the winner..."
      compare_values(player_hand, dealer_hand)
      play_again?()
    end
  end
  
  def dealer_hit(deck, player_hand, dealer_hand) do
      IO.puts "Dealer hits."
      {new, rest} = deal(deck, 1)
      IO.puts "Dealer draws #{new}"  
      if get_value(dealer_hand ++ new) > 21 do
        IO.puts "Dealer busted! You win!"
        IO.puts "Your hand was: #{print_hand(player_hand)}"
        IO.puts "Dealer's hand was: #{print_hand(dealer_hand ++ new)}"
        play_again?()
      else
        dealer_turn(rest, player_hand, dealer_hand ++ new)
      end
  end

  def compare_values(player_hand, dealer_hand) do
    IO.puts("Your score: #{get_value(player_hand)}")
    IO.puts("Dealer's score: #{get_value(dealer_hand)}")
    cond do
      get_value(player_hand) > get_value(dealer_hand) ->
        IO.puts "You win! YAY!"
      get_value(dealer_hand) > get_value(player_hand) ->
        IO.puts "Dealer wins. Too bad."
      get_value(dealer_hand) == get_value(player_hand) ->
        IO.puts "It's a push!"
    end
  end
  
  def play_again? do
    decision = IO.gets("Do you want to play again? ") |> String.trim |> String.downcase
    if Enum.member?(["yes", "y"], decision) == true do
      play()
    end
  end
end