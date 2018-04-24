defmodule Blackjack do

  def start do
    IO.puts("*** Let's play Blackjack! ***")
    generate_deck()
    |> Enum.shuffle
    |> play()
  end
  
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
    if length(hand) == true && get_value(hand) == 21 do
      true
    else
      false
    end
  end
  
  
  def play(deck) do
    {player_hand, deck} = deal(deck)
    
    if blackjack?(player_hand) do
      IO.puts "You got a blackjack! You had good luck!"
      IO.puts "Your hand was: #{player_hand}"
      play_again?()
    else
      {dealer_hand, deck} = deal(deck)
    
      if blackjack?(dealer_hand) do
        IO.puts "Dealer got a blackjack! You had bad luck!"
        IO.puts "Dealer's hand was: #{dealer_hand}"
        play_again?()
      else  
        player_turn(deck, player_hand, dealer_hand)
      end
    end
  end
  
  
  def player_turn(deck, player_hand, dealer_hand) do
    IO.puts("Your hand: #{player_hand}")
    
    {hole_card, shown_cards} = Enum.split(dealer_hand, 1)
    IO.puts("Dealer's hand: #{shown_cards}")
    decision = IO.get("Do you want to [h]it or [s]tand?") |> String.trim
    
    if Enum.member?(["H", "h", "hit"], decision) == true do
      {new, deck} = deal(deck, 1)
      if get_value(player_hand ++ new) > 21 do
        IO.puts "You busted!"
        IO.puts "Your hand was: #{player_hand ++ new}"
        IO.puts "Dealer's hand was: #{dealer_hand}"
        play_again?()
      end
      dealer_turn(deck, player_hand ++ new, dealer_hand, false)
    else
      dealer_turn(deck, player_hand, dealer_hand, true)
    end    
  end
  
  
  def dealer_turn(deck, player_hand, dealer_hand, player_stand) do
    dealer_hand = 
      if get_value(dealer_hand) < 17 do
        IO.puts "Dealer hits."
        {new, deck} = deal(deck, 1)
        dealer_hand ++ new
      else
        IO.puts "Dealer stands."
        dealer_hand
      end
      
    if get_value(dealer_hand) > 21 do
      IO.puts "Dealer busted! You win!"
      IO.puts "Your hand was: #{player_hand}"
      IO.puts "Dealer's hand was: #{dealer_hand}"
      play_again?()
    end
    
    if player_stand == false do
      player_turn(deck, player_hand, dealer_hand)
    else
      if get_value(dealer_hand) < 17 do
        dealer_turn(deck, player_hand, dealer_hand, player_stand)
      else
        compare_values(player_hand, dealer_hand)
        play_again?()
      end
    end  
  end
  
    
  def play_again? do
    decision = IO.gets("Do you want to play again? ") |> String.trim
    if Enum.member?(["yes", "y"], decision |> String.downcase) == true do
      clear()
      start()
    else
      nil
    end
  end
  
  
  def compare_values(player_hand, dealer_hand) do
    # TODO: Put some code here!
  end
end