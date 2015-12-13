require 'spec_helper.rb'

describe "day 13" do
  context "part 1" do
    it "finds the correct seatings for the sample input" do
      lines = [
        "Alice would gain 54 happiness units by sitting next to Bob.",
        "Alice would lose 79 happiness units by sitting next to Carol.",
        "Alice would lose 2 happiness units by sitting next to David.",
        "Bob would gain 83 happiness units by sitting next to Alice.",
        "Bob would lose 7 happiness units by sitting next to Carol.",
        "Bob would lose 63 happiness units by sitting next to David.",
        "Carol would lose 62 happiness units by sitting next to Alice.",
        "Carol would gain 60 happiness units by sitting next to Bob.",
        "Carol would gain 55 happiness units by sitting next to David.",
        "David would gain 46 happiness units by sitting next to Alice.",
        "David would lose 7 happiness units by sitting next to Bob.",
        "David would gain 41 happiness units by sitting next to Carol.",
      ]

      expect(maximal_seating_happiness(lines)).to eq 330
    end

    it "finds the correct seatings for the input file" do
      lines = File.readlines("data/input13.txt").map(&:strip)
      expect(maximal_seating_happiness(lines)).to eq 709
    end
  end

  context "part 2" do
    it "finds the correct seatings for the input file" do
      lines = File.readlines("data/input13.txt").map(&:strip)
      expect(maximal_seating_happiness(lines, true)).to eq 668
    end
  end
end
