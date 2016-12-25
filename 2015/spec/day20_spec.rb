require 'spec_helper.rb'

describe "day 20" do
  context "divisors" do
    it "finds divisors correctly" do
      expect(divisors(4)).to eq Set.new([1,2,4])
    end
  end

  context "part 1" do
    it "works for low numbers" do
      expect(house_presents(1)).to eq 10
      expect(house_presents(2)).to eq 30
      expect(house_presents(3)).to eq 40
      expect(house_presents(4)).to eq 70
      expect(house_presents(5)).to eq 60
      expect(house_presents(6)).to eq 120
      expect(house_presents(7)).to eq 80
      expect(house_presents(8)).to eq 150
      expect(house_presents(9)).to eq 130
      expect(house_presents(10)).to eq 180
      expect(house_presents(11)).to eq 120
      expect(house_presents(12)).to eq 280
    end

    it "works for the big one" do
      expect(house_with_lots_of_presents).to eq 776160
    end
  end

  context "part 2" do
    it "works for the input given" do
      expect(modified_house_with_lots_of_presents).to eq 786240
    end
  end
end
