require 'rspec'
require 'card.rb'

describe Hand do
  subject(:deck) { Deck.new }
  subject(:hand) { Hand.new(deck) }
  subject(:other_hand) { Hand.new(deck) }

  da = Card.new(:ace, :diamond)
  d2 = Card.new(:two, :diamond)
  d3 = Card.new(:three, :diamond)
  d4 = Card.new(:four, :diamond)
  d5 = Card.new(:five, :diamond)
  d6 = Card.new(:six, :diamond)
  d7 = Card.new(:seven, :diamond)
  d8 = Card.new(:eight, :diamond)
  d9 = Card.new(:nine, :diamond)
  dt = Card.new(:ten, :diamond)
  dj = Card.new(:jack, :diamond)
  dq = Card.new(:queen, :diamond)
  dk = Card.new(:king, :diamond)
  ha = Card.new(:ace, :heart)
  h2 = Card.new(:two, :heart)
  h3 = Card.new(:three, :heart)
  h4 = Card.new(:four, :heart)
  h5 = Card.new(:five, :heart)
  h6 = Card.new(:six, :heart)
  h7 = Card.new(:seven, :heart)
  h8 = Card.new(:eight, :heart)
  h9 = Card.new(:nine, :heart)
  ht = Card.new(:ten, :heart)
  hj = Card.new(:jack, :heart)
  hq = Card.new(:queen, :heart)
  hk = Card.new(:king, :heart)
  sa = Card.new(:ace, :spade)
  s2 = Card.new(:two, :spade)
  s3 = Card.new(:three, :spade)
  s4 = Card.new(:four, :spade)
  s5 = Card.new(:five, :spade)
  s6 = Card.new(:six, :spade)
  s7 = Card.new(:seven, :spade)
  s8 = Card.new(:eight, :spade)
  s9 = Card.new(:nine, :spade)
  st = Card.new(:ten, :spade)
  sj = Card.new(:jack, :spade)
  sq = Card.new(:queen, :spade)
  sk = Card.new(:king, :spade)
  ca = Card.new(:ace, :club)
  c2 = Card.new(:two, :club)
  c3 = Card.new(:three, :club)
  c4 = Card.new(:four, :club)
  c5 = Card.new(:five, :club)
  c6 = Card.new(:six, :club)
  c7 = Card.new(:seven, :club)
  c8 = Card.new(:eight, :club)
  c9 = Card.new(:nine, :club)
  ct = Card.new(:ten, :club)
  cj = Card.new(:jack, :club)
  cq = Card.new(:queen, :club)
  ck = Card.new(:king, :club)

  describe "#initialize" do
    it "should start with 5 cards in hand" do
      expect(hand.cards.count).to eq(5)
    end
  end

  describe "#exchange" do
    it "should maintain five cards cards" do
      to_exchange = hand.cards.sample(3)
      hand.exchange(to_exchange)
      expect(hand.cards.count).to eq(5)
    end

    it "should get back different cards" do
      before_exchange = hand.cards.dup
      to_exchange = hand.cards.sample(3)
      hand.exchange(to_exchange)
      expect(before_exchange).to_not equal(hand.cards)
    end
  end

  it " should detect four of a kind" do
    hand.cards = [da,sa,ha,dq,ca]
      expect(hand.four_of_a_kind).to eql([true, 14])
      hand.cards.pop
      hand.cards << s4
      expect(hand.four_of_a_kind).to eql([false, nil])
  end

  it "should detect three of a kind" do
    hand.cards = [d2, ca, h2, c2, s4]
    expect(hand.three_of_a_kind).to eql([true, 2, [14, 4]])
  end


  describe "#flush" do
    it "should detect a flush" do
      hand.cards = [d2, d3, d5, d9, dk]
      expect(hand.flush?).to be true
    end

    it "should not detect a non-flush" do
      hand.cards = [d2, d3, d5, d9, h7]
      expect(hand.flush?).to be false
    end
  end

  describe "#straight" do
    context "without an ace" do
      it "should detect a straight" do
        hand.cards = [d4, h5, d6, s7, h8]
        expect(hand.straight).to eql([true, 8])
      end

      it "should not detect a non-straight" do
        hand.cards = [d4, d6, d7, d8, hk]
        expect(hand.straight).to eql([false, nil])
      end
    end

    context "with an ace" do
      it "should detect a low straight" do
        hand.cards = [ha, h2, d3, s4, c5]
        expect(hand.straight).to eql([true, 5])
      end

      it "should detect a high straight" do
        hand.cards = [ha, ck, sq, sj, ct]
        expect(hand.straight).to eql([true, 14])
      end

      it "should not detect a wrap-around straight" do
        hand.cards = [ha, ck, sq, h2, c3]
        expect(hand.straight).to eql([false, nil])
      end
    end
  end

  describe "#find_hand_value" do
    it "should detect a royal flush" do
      hand.cards = [hk, ha, hq, ht, hj]
      expect(hand.find_hand_value).to eql(["Royal Flush"])
    end

    it "should detect a straight flush" do
      hand.cards = [dt, d9, d8, d7, d6]
      expect(hand.find_hand_value).to eql(["straight flush", nil, [10]])
    end

    it "should detect four of a kind" do
      hand.cards = [c5, s5, h5, d5, dq]
      expect(hand.find_hand_value).to eql(["four of a kind", 5])
    end

    it "should detect a full house" do
      hand.cards = [dt, st, ct, ca, da]
      expect(hand.find_hand_value).to eql(["full house", 10, 14])
    end

    it "should detect a flush" do
      hand.cards = [dt, d5, d4, da, dk]
      expect(hand.find_hand_value).to eql(["flush", nil, [14, 13, 10, 5, 4]])
    end

    it "should detect a straight" do
      hand.cards = [d6, c5, c4, s7, h8]
      expect(hand.find_hand_value).to eql(["straight", nil, [8]])
    end

    it "should detect three of a kind" do
      hand.cards = [d5, c5, ca, d4, h5]
      expect(hand.find_hand_value).to eql(["three of a kind", nil, [5]])
    end

    it "should detect two pair" do
      hand.cards = [dt, ct, hq, sq, c9]
      expect(hand.find_hand_value).to eql(["two pair", 12, [10, 9]])
    end

    it "should detect one pair" do
      hand.cards = [cq, sq, c9, c2, h4]
      expect(hand.find_hand_value).to eql(["pair", 12, [9, 4, 2]])
    end

    it "should detect high card" do
      hand.cards = [cq, st, h4, h2, d8]
      expect(hand.find_hand_value).to eql(["high card", nil, [12, 10, 8, 4, 2]])
    end
  end

  describe "#compare_hand" do
    context "without tie breakers" do
      it "should correctly name a Royal Flush as the winner" do
        hand.cards = [ca, ck, ct, cq, cj]
        other_hand.cards = [hk, hj, ht, hq, h9]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should correctly name a straight flush as the winner" do
        hand.cards = [ca, c2, c3, c4, c5]
        other_hand.cards = [ck, hk, sk, hq, cq]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should correctly name four of a kind as the winner" do
        hand.cards = [ca, c2, c3, c4, h5]
        other_hand.cards = [c6, s6, h6, d6, da]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should correctly name a full house as the winner" do
        hand.cards = [ca, sa, ha, hk, hq]
        other_hand.cards = [s2, c2, d2, d3, c3]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should correctly name a flush as the winner" do
        hand.cards = [s2, c2, d2, d3, c3]
        other_hand.cards = [ca, sa, ha, hk, hq]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should correctly name a straight as the winner" do
        hand.cards = [s3, s4, s5, c6, d7]
        other_hand.cards = [s9, st, sj, da, ca]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should correctly name three of a kind as the winner" do
        hand.cards = [s3, c3, d3, cq, ha]
        other_hand.cards = [sq, hq, h2, c2, s5]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should correctly name two pair as the winner" do
        hand.cards = [s3, s4, c4, h3, ha]
        other_hand.cards = [s9, st, sj, da, ca]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should correctly name one pair as the winner" do
        hand.cards = [s3, s4, s5, c6, s6]
        other_hand.cards = [s9, s4, sj, dt, ca]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end
    end

    context "with ties" do
      it "should report two Royal Flushes as a tie" do
        hand.cards = [ca, ck, ct, cq, cj]
        other_hand.cards = [hk, hj, ht, hq, ha]
        expect(hand.compare_hand(other_hand)).to eql(0)
      end

      it "should report a higher straight flush as the winner" do
        hand.cards = [ca, c2, c3, c4, c5]
        other_hand.cards = [h6, h7, h8, h9, ht]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should name a higher four of a kind as the winner" do
        hand.cards = [ca, s5, d5, c5, h5]
        other_hand.cards = [c6, s6, h6, d6, da]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should name a higher full house as the winner" do
        hand.cards = [h2, d2, d4, c4, h4]
        other_hand.cards = [s2, c2, d2, d3, c3]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should name a higher flush as the winner" do
        hand.cards = [cj, ct, c9, c6, c3]
        other_hand.cards = [sq, s2, s3, s4, s9]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should name winner in a flush with 4 same-value cards" do
        hand.cards = [cj, ct, c9, c6, c3]
        other_hand.cards = [sj, s9, s6, s2, st]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should report a tie with tied flushes" do
        hand.cards = [cj, ct, c9, c6, c3]
        other_hand.cards = [sj, s9, s6, s3, st]
        expect(hand.compare_hand(other_hand)).to eql(0)
      end

      it "should correctly name a higher straight as the winner" do
        hand.cards = [s3, s4, s5, c6, d7]
        other_hand.cards = [s9, st, sj, dq, c8]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should report tied straights" do
        hand.cards = [s3, s4, s5, c6, d7]
        other_hand.cards = [s7, s6, c5, d4, d3]
        expect(hand.compare_hand(other_hand)).to eql(0)
      end

      it "should correctly name higher three of a kind as the winner" do
        hand.cards = [s3, c3, d3, cq, ha]
        other_hand.cards = [sq, hq, dq, c2, s5]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should correctly name a higher two pair as the winner" do
        hand.cards = [s3, s4, c4, h3, ha]
        other_hand.cards = [s5, c5, sa, da, dt]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should move to the second pair when top pair is tied" do
        hand.cards = [d4, s4, ca, ha, h2]
        other_hand.cards = [s5, c5, sa, da, dt]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should consider the kicker when both pairs are the same" do
        hand.cards = [d5, h5, ca, ha, d8]
        other_hand.cards = [s5, c5, sa, da, dt]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should correctly name a higher pair as the winner" do
        hand.cards = [s3, s4, s5, c6, s6]
        other_hand.cards = [s7, c7, sj, dt, ca]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should move to the kicker when pairs are tied" do
        hand.cards = [s3, s4, s5, c6, s6]
        other_hand.cards = [h6, d6, sj, dt, ca]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should go to the bottom kicker when pairs are tied" do
        hand.cards = [hj, h7, sa, c6, s6]
        other_hand.cards = [h6, d6, sj, dt, ca]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should report the highest card as the winner" do
        hand.cards = [hj, h7, sa, c6, d5]
        other_hand.cards = [h6, d3, sj, dt, ck]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should move down to a lower kicker" do
        hand.cards = [hj, h7, sa, c6, d5]
        other_hand.cards = [h6, d3, sj, dt, ca]
        expect(hand.compare_hand(other_hand)).to eql(-1)
      end

      it "should move down to the lowest kicker" do
        hand.cards = [hj, ht, sa, c6, d5]
        other_hand.cards = [h6, d3, sj, dt, ca]
        expect(hand.compare_hand(other_hand)).to eql(1)
      end

      it "should correctly call a tied high card hand" do
        hand.cards = [hj, ht, sa, c6, c3]
        other_hand.cards = [h6, d3, sj, dt, ca]
        expect(hand.compare_hand(other_hand)).to eql(0)
      end
    end
  end
end
