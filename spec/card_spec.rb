require 'card'
require 'hand'

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
