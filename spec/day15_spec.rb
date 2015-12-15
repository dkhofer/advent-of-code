require 'spec_helper.rb'

describe "day 15" do
  context "part 1" do
    it "finds the maximal score for the sample inputs given" do
      lines = [
        "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8",
        "Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3",
      ]

      expect(find_optimal_cookie(lines)).to eq 62842880
    end

    it "finds the maximal score for the input file" do
      lines = File.readlines("data/input15.txt")
      expect(find_optimal_cookie(lines)).to eq 13882464
    end
  end

  context "part 2" do
    it "finds the maximal score for the sample inputs given" do
      lines = [
        "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8",
        "Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3",
      ]

      expect(find_optimal_cookie(lines, true)).to eq 57600000
    end

    it "finds the maximal score for the input file" do
      lines = File.readlines("data/input15.txt")
      expect(find_optimal_cookie(lines, true)).to eq 11171160
    end
  end
end
