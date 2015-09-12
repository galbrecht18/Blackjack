#Lesson One Blackjack Game
#9-8-2015 Initial Version
#George Albrecht

#Automatically stop when player has 21

require 'pry'

#does deck need to be a constant? Its being mutated throughout so not sure
deck = {
  "Spades" => {"Ace"=>1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, 
    "7"=>7, "8"=>8, "9"=>9, "10"=>10, "Jack"=>10, "Queen"=>10, "King"=>10},
  "Clubs" => {"Ace"=>1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, 
    "7"=>7, "8"=>8, "9"=>9, "10"=>10, "Jack"=>10, "Queen"=>10, "King"=>10},
  "Hearts" => {"Ace"=>1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, 
    "7"=>7, "8"=>8, "9"=>9, "10"=>10, "Jack"=>10, "Queen"=>10, "King"=>10},
  "Diamonds" => {"Ace"=>1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, 
    "7"=>7, "8"=>8, "9"=>9, "10"=>10, "Jack"=>10, "Queen"=>10, "King"=>10}
  }

def get_name

  puts "What is your name?"
  player_name = gets.chomp
  puts "Welcome and good luck #{player_name.capitalize!}"
  player_name

end 

def deal_cards deck, num_of_deals

  cards = []
  card_value = nil

  num_of_deals.times do
    random_suit = deck.keys.sample
    card_key = deck[random_suit].keys.sample
    card_value = check_if_ace(card_key, card_value)
    if card_value == nil then card_value = deck[random_suit].delete(card_key)
    else deck[random_suit].delete(card_key) end 
    cards << [random_suit, card_key, card_value]
  end 

  cards

end 

def check_if_ace card_key, card_value

  if card_key == 'Ace'
    puts "Got an ace. Do you want ace high or ace low? (low/high)?"
    ace_choice = gets.chop.to_s.upcase
    if ace_choice == "HIGH"
      card_value = 11
      return card_value
    elsif ace_choice == "LOW"
      card_value = 1
      return card_value
    else 
      puts "Not a valid input, please input (low/high)."
      check_if_ace(card_key, card_value)
    end 
  end 

end 

def calculate_card_total cards

  total = 0
  cards.each do |card|
    if card[2] then total += card[2] end 
  end 
  total

end 

def out_put_cards_and_total player_cards, player_total

  puts "*****"
  puts "Your cards are: the #{player_cards[0][1]} of #{player_cards[0][0]} and the #{player_cards[1][1]} of #{player_cards[1][0]}"
  remainder_until_21 = 21 - player_total
  puts "Your card total is #{player_total}. You have #{remainder_until_21} to go until 21."
  puts "*****"

end 

def hit_or_stay deck, player_cards, player_total

  puts "Do you want to \'hit\' or \'stay\'?"
  choice = gets.chomp.to_s.upcase!
  if choice == 'HIT'
    player_cards << deal_cards(deck, 1).flatten
    return player_cards
  elsif choice == 'STAY'
    puts "You have stayed. Your total is #{player_total}."
    return choice
  else 
    puts "Please enter a valid choice (hit/stay)."
  end 

end 

def check_for_bust card_total, name

  if card_total > 21

    bust = true

  end 

end 

def check_for_win player_total, computer_total

  if player_total > computer_total 
    puts "You have #{player_total}, computer have #{computer_total}...You WIN!"
  elsif computer_total > player_total
    puts "Computer has #{computer_total}, you have #{player_total}...You lose sorry."
  else 
    puts "Tie?!?"
  end 

end 

#begin the game
begin 

  system('clear')
  puts "Welcome to Blackjack!"
  player_name = get_name

  #deal the cards
  puts "Dealing your cards..."
  sleep(1)
  player_cards = deal_cards(deck, 2)
  player_total = calculate_card_total(player_cards)
  out_put_cards_and_total(player_cards, player_total)
  computer_cards = deal_cards(deck, 2)
  computer_total = calculate_card_total(computer_cards)

  hit_or_stay = ''

  #start asking for hit or stay
  while player_total <= 21 && hit_or_stay != "STAY" do
      
    hit_or_stay = hit_or_stay(deck, player_cards, player_total)

    if hit_or_stay && hit_or_stay != "STAY"
      player_cards = hit_or_stay
      player_total = calculate_card_total(player_cards)
      puts "Your cards are #{player_cards}"
      puts "Your total is #{player_total}."

    end 

  end 

  player_bust =  check_for_bust(player_total, player_name)

  #right now if player stays, sometimes it hangs in loop

  if player_bust 
    puts "Bust! Computer won!"
  else 
    while computer_total < 17 do
      computer_cards << deal_cards(deck, 1).flatten
      computer_total = calculate_card_total(computer_cards)
    end 
    computer_bust = check_for_bust(computer_total, 'Computer')
    if computer_bust 
      puts "Computer bust! You win! Computer total is #{computer_total}."
    else 
      check_for_win(player_total, computer_total)
    end 
  end 

  puts "Play again? (y/n)?"
  play_again = gets.chomp.to_s.upcase
end until play_again != 'Y'
puts "Thanks for playing #{player_name}!"




















