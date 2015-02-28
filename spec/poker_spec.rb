require 'rspec'
require 'card.rb'
require 'facets'

describe Card do
  subject(:card) { Card.new(:ace, :diamond) }

  describe "#initialize" do
    it "should hold a rank" do
      expect(card.rank).to eq(:ace)
    end

    it "should hold a suit" do
      expect(card.suit).to eq(:diamond)
    end
  end
end

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "should start with 52 cards" do
      expect(deck.cards.count).to eq(52)
    end
  end

  describe "#shuffle" do
    it "should shuffle randomly" do
      expect(deck.shuffle).to_not eq(deck.shuffle)
    end
  end

  describe "#deal" do
    it "should deal multiple cards" do
      deck.deal(3)
      expect(deck.cards.count).to eq(49)
    end

    it "should deal one card" do
      deck.deal(1)
      expect(deck.cards.count).to eq(51)
    end
  end

  describe "#return_card" do
    it "should return card to the deck" do
      deck.deal(5)
      deck.take(Card.new(:ace, :diamond))
      expect(deck.cards.count).to eq(48)
    end
  end
end

describe Hand do
  subject(:hand) { Hand.new(Deck.new) }

  describe "#initialize" do
    it "should start with 5 cards in hand" do
      expect(hand.cards_in_hand.count).to eq(5)
    end
  end

  describe "#exchange" do
    it "should get back the right number of cards" do
      before_exchange = hand.cards_in_hand
      to_exchange = hand.cards_in_hand.sample(3)
      hand.exchange(to_exchange)

      expect(hand.cards_in_hand.count).to eq(5)
      expect(hand.cards_in_hand.frequency).to_not eq(before_exchange.frequency)
    end
  end

  # describe "#rank" do
  #   it "should be able to tell the hand's value" do
  #
  #   end
  #
  #   it "should tell the correct value of the current hand" do
  #
  #   end
  # end
  diamond = Card.new(:ace, :diamond)
  hand.cards_in_hand = [
    diamond,
    Card.new(:ace, :club),
    Card.new(:ace, :heart),
    Card.new(:three, :club),
    Card.new(:ace, :spade)
  ]

  it " should detect four of a kind" do
      expect(hand.four_of_a_kind).to eql([true, :ace])
      hand.cards_in_hand.pop
      hand.cards_in_hand << Card.new(:four, :spade)
      expect(hand.four_of_a_kind).to eql([false, nil])
  end

  it "should detect three of a kind" do
    hand.cards_in_hand = [Card.new(:two, :diamond), Card.new(:ace, :club),
        Card.new(:two, :heart), Card.new(:two, :club),
        Card.new(:four, :spade)]
    expect(hand.three_of_a_kind).to eql([true, :two])
  end


      # describe "#flush" do
      #
      # end
      #
      # describe "#straight" do
      #
      # end
      #
      # describe "#straight flush" do
      #
      # end
      #
      # describe "#full_house" do
      #
      # end


end
