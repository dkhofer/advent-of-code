require 'spec_helper.rb'

describe "day 16" do
  context "part 1" do
    it "finds the matching Aunt Sue" do
      lines = File.readlines("data/input16.txt").map(&:strip)
      expect(find_matching_sue(lines)).to eq 373
    end
  end

  context "part 2" do
    it "finds the REAL Aunt Sue" do
      lines = File.readlines("data/input16.txt").map(&:strip)
      expect(find_real_matching_sue(lines)).to eq 260
    end
  end
end
