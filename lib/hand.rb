require_relative 'card'

class Hand
  attr_accessor :cards

  HAND_RANKING = ["Royal Flush", "straight flush", "four of a kind",
                 "full house", "flush", "straight", "three of a kind",
                 "two pair", "pair", "high card"]

  def initialize(deck, size = 5)
    @deck = deck
    @cards = @deck.deal(size)
  end

  def exchange(cards)
    num = cards.length
    cards.each do |card|
      @deck.take(card)
      @cards.delete(card)
    end

    @cards += @deck.deal(num)
  end

  def sorted_ranks
    ranks = []
    @cards.each do |card|
      ranks << card.rank
    end

    ranks.map { |rank| Card::RANKS[rank] }.sort
  end

  def find_hand_value
    return ["Royal Flush"] if flush? && straight[0] && straight[1] == 14
    return ["straight flush", nil, [straight[1]]] if flush? && straight[0]
    if four_of_a_kind[0]
      return ["four of a kind", four_of_a_kind[1]]
    end
    if three_of_a_kind[0]
      left_over = pair_checker(three_of_a_kind[2])
      return ["full house", three_of_a_kind[1], left_over[1]] if left_over[1]
    end
    return ["flush", nil, high_cards] if flush?
    return ["straight", nil, [straight[1]]] if straight[0]
    if three_of_a_kind[0]
      return ["three of a kind", nil, [three_of_a_kind[1]]]
    end
    return pair_checker unless pair_checker[1].nil?
    ["high card", nil, high_cards]
  end

  def flush?
    suit = @cards.first.suit
    @cards.each do |card|
      return false unless card.suit == suit
    end

    true
  end

  def straight
    values = sorted_ranks
    if values.include?(14)
      ace_high = straight_checker(values)
      return ace_high if ace_high[0]
      values[-1] = 1
      values.sort!
    end

    straight_checker(values)
  end

  def three_of_a_kind
    output = [false, nil, nil]
    cards = sorted_ranks.dup
    cards.each do |rank|
      if cards.count(rank) == 3
        output[0] = true
        output[1] = rank
      end
    end
    if output[0]
      cards.delete(output[1])
      output[2] = cards.sort.reverse
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

  def high_cards(cards = sorted_ranks)
    cards.reverse
  end

  def compare_hand(other_hand)
    type, value, tiebreakers = find_hand_value
    type2, value2, tiebreakers2 = other_hand.find_hand_value
    if HAND_RANKING.index(type) < HAND_RANKING.index(type2)
      return 1
    elsif HAND_RANKING.index(type) > HAND_RANKING.index(type2)
      return -1
    else
      if value.nil? || value2.nil?
        return tie_breaker(tiebreakers, tiebreakers2)
      end
      return 1 if value > value2
      return -1 if value < value2
      tie_breaker(tiebreakers, tiebreakers2)
    end
  end

  private

  def tie_breaker(this_hand, other_hand)
    return 0 if this_hand.nil? || other_hand.nil?
    this_hand.sort!.reverse!
    other_hand.sort!.reverse!
    this_hand.each_with_index do |rank, idx|
      return 1 if rank > other_hand[idx]
      return -1 if rank < other_hand[idx]
    end

    0
  end

  def pair_checker(cards = sorted_ranks)
    hash = cards.group_by { |card| card }
    if hash.length == 3
      pairs = []
      hash.each { |k, v| pairs << k if v.length == 2 && !pairs.include?(k)}
      pairs.sort!.reverse!
      hash.each { |k, v| pairs << k if v.length == 1 }
      return ["two pair", pairs[0], [pairs[1], pairs[2]]]
    end

    pair = nil
    remainder = []
    hash.each { |k, v| pair = k if v.length == 2 }
    hash.each { |k, v| remainder << k if v.length == 1 }


    ["pair", pair, remainder.sort.reverse]
  end

  def straight_checker(ranks)
    0.upto(3).each do |idx1|
      idx2 = idx1 + 1
      return [false, nil] if ranks[idx2] - ranks[idx1] != 1
    end
    [true, ranks.last]
  end
end
