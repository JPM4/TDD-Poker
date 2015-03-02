require 'player'

describe HumanPlayer do
  subject(:deck) { Deck.new }
  subject(:player) { HumanPlayer.new("Jane", 500, deck) }
  subject(:hand1) { Hand.new(deck) }
  subject(:hand2) { Hand.new(deck) }

  describe "#initialize" do
    it "should start player with a name" do
      expect(player.name).to eql("Jane")
    end

    it "should start player with their bankroll" do
      expect(player.bankroll).to eql(500)
    end

    it "should give player access to the deck" do
      expect(player.deck).to be_a Deck
    end
  end

  describe "#receive_new_hand" do
    it "should give the player a new hand" do
      player.receive_new_hand(hand1)
      expect(player.hand).to be_a Hand
    end

    it "should give the player different hands" do
      this_hand1 = player.receive_new_hand(hand1)
      this_hand2 = player.receive_new_hand(hand2)
      expect(this_hand1).to_not eql(this_hand2)
    end
  end
  #
  # describe "#discard" do
  #   it "should change the player's hand" do
  #     player.receive_new_hand(hand1)
  #     this_hand1 = player.hand
  #     player.discard()
  #
  #   end
  # end


end
