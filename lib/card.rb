require_relative 'deck.rb'
require_relative 'hand.rb'

class Card

  RANKS = { :two => 2,
            :three => 3,
            :four => 4,
            :five => 5,
            :six => 6,
            :seven => 7,
            :eight => 8,
            :nine => 9,
            :ten => 10,
            :jack => 11,
            :queen => 12,
            :king => 13,
            :ace => 14 }

  SUITS = [:club, :diamond, :spade, :heart]

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def rank
    @rank
  end

  def suit
    @suit
  end
end
