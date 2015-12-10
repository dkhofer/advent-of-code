require 'spec_helper.rb'

describe "day2" do
  context "wrapping paper" do
    it "works on provided examples" do
      expect(wrapping_paper([[2,3,4]])).to eq 58
      expect(wrapping_paper([[1,1,10]])).to eq 43
    end

    it "works on the input file" do
      boxes = File.readlines("data/input2.txt").map(&:strip).map { |line| line.split("x").map(&:to_i) }
      expect(wrapping_paper(boxes)).to eq 1588178
    end
  end

  context "ribbons" do
    it "works on provided examples" do
      expect(ribbon([[2,3,4]])).to eq 34
      expect(ribbon([[1,1,10]])).to eq 14
    end

    it "works on the input file" do
      boxes = File.readlines("data/input2.txt").map(&:strip).map { |line| line.split("x").map(&:to_i) }
      expect(ribbon(boxes)).to eq 3783758
    end
  end
end
