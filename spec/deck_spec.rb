require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "should start with 52 cards" do
      expect(deck.cards.count).to eq(52)
    end
  end

  describe "#shuffle" do
    it "should shuffle" do
      before_shuffle = deck.cards.dup
      deck.shuffle
      expect(before_shuffle).to_not eq(deck.cards)
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
