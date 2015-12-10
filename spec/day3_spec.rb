require 'spec_helper.rb'

describe "day3" do
  context "part 1" do
    it "works on provided examples" do
      expect(house_count(">".split(""))).to eq 2
      expect(house_count("^>v<".split(""))).to eq 4
      expect(house_count("^v^v^v^v^v".split(""))).to eq 2
    end

    it "works on the input file" do
      moves = File.readlines("data/input3.txt").first.strip.split("")
      expect(house_count(moves)).to eq 2081
    end
  end

  context "robo-santa" do
    it "works on provided examples" do
      expect(robo_house_count("^v".split(""))).to eq 3
      expect(robo_house_count("^>v<".split(""))).to eq 3
      expect(robo_house_count("^v^v^v^v^v".split(""))).to eq 11
    end

    it "works on the input file" do
      moves = File.readlines("data/input3.txt").first.strip.split("")
      expect(robo_house_count(moves)).to eq 2341
    end
  end
end
