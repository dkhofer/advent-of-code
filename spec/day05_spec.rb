require 'spec_helper.rb'

describe "day5" do
  context "part 1" do
    def part1_nice_test(word, expected_value)
      expect(part1_nice_word(word)).to be expected_value
    end

    it "detects example nice words correctly" do
      part1_nice_test("aei", false)
      part1_nice_test("xazegov", false)
      part1_nice_test("aeiouaeiouaeiou", false)

      part1_nice_test("ugknbfddgicrmopn", true)
      part1_nice_test("aaa", true)
      part1_nice_test("jchzalrnumimnmhp", false)
      part1_nice_test("haegwjzuvuyypxyu", false)
      part1_nice_test("dvszwmarrgswjxmb", false)
    end

    it "counts the nice words in a file" do
      words = File.readlines("data/input5.txt").map(&:strip)
      expect(words.count(&method(:part1_nice_word))).to eq 255
    end
  end

  context "part 2" do
    def part2_nice_test(word, expected_value)
      expect(part2_nice_word(word)).to eq expected_value
    end

    it "detects example nice words correctly" do
      part2_nice_test("qjhvhtzxzqqjkmpb", true)
      part2_nice_test("xxyxx", true)
      part2_nice_test("uurcxstgmygtbstg", false)
      part2_nice_test("ieodomkazucvgmuy", false)
    end

    it "counts the nice words in a file" do
      words = File.readlines("data/input5.txt").map(&:strip)
      expect(words.count(&method(:part2_nice_word))).to eq 55
    end
  end
end
