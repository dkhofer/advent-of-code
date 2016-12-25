require 'spec_helper.rb'

describe "day 18" do
  context "part 1" do
    it "works on the sample input given" do
      lines = [
        ".#.#.#",
        "...##.",
        "#....#",
        "..#...",
        "#.#..#",
        "####..",
      ]
      expect(lit_count(lines, 4)).to eq 4
    end

    it "works on the input file" do
      lines = File.readlines("data/input18.txt").map(&:strip)
      expect(lit_count(lines, 100)).to eq 821
    end
  end

  context "part 2" do
    it "works on the sample input given" do
      lines = [
        "##.#.#",
        "...##.",
        "#....#",
        "..#...",
        "#.#..#",
        "####.#",
      ]
      expect(lit_count(lines, 5, false, true)).to eq 17
    end

    it "works on the input file" do
      lines = File.readlines("data/input18.txt").map(&:strip)
      expect(lit_count(lines, 100, false, true)).to eq 886
    end
  end
end
