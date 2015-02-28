class Deck
  attr_reader :cards

  def initialize
    @cards = []
    new_deck
  end

  def new_deck
    Card::RANKS.keys.each do |rank|
      Card::SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    @cards.shuffle
  end

  def deal(num)
    cards = []
    num.times do
      cards << @cards.pop
    end

    cards
  end

  def take(card)
    @cards.unshift(card)
  end
end
