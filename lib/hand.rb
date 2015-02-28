class Hand
  attr_accessor :cards_in_hand

  def initialize(deck, size = 5)
    @deck = deck
    @cards_in_hand = @deck.deal(size)
  end

  def exchange(cards)
    num = cards.length
    cards.each do |card|
      @deck.take(card)
      @cards_in_hand.delete(card)
    end

    @cards_in_hand += @deck.deal(num)
  end

  def sorted_ranks
    ranks = []
    @cards_in_hand.each do |card|
      ranks << card.rank
    end

    ranks.sort
  end

  def flush?

  end

  def straight?

  end

  def straight_flush?
    return true if straight? && flush?
    false
  end

  def full_house

  end

  def three_of_a_kind
    output = [false, nil]
    sorted_ranks.each do |rank|
      if sorted_ranks.count(rank) == 3
        output[0] = true
        output[1] = rank
      end
    end

    output
  end

  def four_of_a_kind
    output = [false, nil]
    sorted_ranks.each do |rank|
      if sorted_ranks.count(rank) == 4
        output[0] = true
        output[1] = rank
      end
    end

    output
  end

  def pair

  end

  def two_pair

  end

  def high_card

  end
end
