require 'spec_helper.rb'

describe "day6" do
  context "part 1" do
    it "turns on" do
      rectangle = [[1,1], [4,6], :on]
      expect(count_lights([rectangle], :part1)).to eq 24
    end

    it "turns off" do
      rectangle1 = [[1,1], [4,6], :on]
      rectangle2 = [[1,1], [2,3], :off]
      expect(count_lights([rectangle1, rectangle2], :part1)).to eq 18
    end

    it "toggles" do
      rectangle1 = [[1,1], [4,6], :on]
      rectangle2 = [[1,1], [10,10], :toggle]
      expect(count_lights([rectangle1, rectangle2], :part1)).to eq 76
    end

    it "counts the number of lights in the input file" do
      lines = File.readlines("data/input6.txt")
      light_count = count_lights(parse_rectangles(lines), :part1)
      expect(light_count).to eq 377891
    end
  end

  context "part 2" do
    it "turns on" do
      rectangle = [[1,1], [4,6], :on]
      expect(count_lights([rectangle, rectangle], :part2)).to eq 48
    end

    it "turns off" do
      rectangle1 = [[1,1], [4,6], :on]
      rectangle2 = [[1,1], [2,3], :off]
      expect(count_lights([rectangle1, rectangle2], :part2)).to eq 18
      expect(count_lights([rectangle1, rectangle2, rectangle2], :part2)).to eq 18
      expect(count_lights([rectangle1, rectangle2, rectangle2, rectangle1], :part2)).to eq 42
      rectangle3 = [[4,6], [4,6], :off]
      expect(count_lights([rectangle1, rectangle2, rectangle2, rectangle1, rectangle3], :part2)).to eq 41
    end

    it "toggles" do
      rectangle1 = [[1,1], [4,6], :on]
      rectangle2 = [[1,1], [10,10], :toggle]
      expect(count_lights([rectangle1, rectangle2], :part2)).to eq 224
    end

    it "counts the number of lights in the input file" do
      lines = File.readlines("data/input6.txt")
      light_count = count_lights(parse_rectangles(lines), :part2)
      expect(light_count).to eq 14110788
    end
  end
end
