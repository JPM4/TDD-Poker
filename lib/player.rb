require_relative 'deck'

class HumanPlayer
  attr_reader :name, :bankroll, :deck, :hand

  def initialize(name, bankroll, deck)
    @name = name
    @bankroll = bankroll
    @deck = deck
  end

  def receive_new_hand(hand)
    @hand = hand
  end

  def discard(cards)
    @hand.exchange(cards)
  end

  def choose_discards
    puts "What cards would you like to discard?"
    puts "Enter numbers between 1-5 separated by spaces (up to 3)."
    puts "Ex: '1 4', '5', '2 3 4', ''"
    input = gets.chomp.split(" ").map { |num| num.to_i }
    discards = parse_input(input)
    discard(discards)
  end

  private

  def parse_input(input)
    raise "not a valid choice" unless input.all? { |num| num.between(1, 5) }
    indexes = input.map { |index| index - 1 }
    discards = []
    indexes.each do |idx|
      discards << @hand[idx]
    end

    discards
  end


end
