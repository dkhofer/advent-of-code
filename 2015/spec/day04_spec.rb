require 'spec_helper.rb'

describe "day4" do
  context "five zeroes" do
    it "works on provided examples" do
      expect(lowest_zero_prefix_number("abcdef", 5)).to eq 609043
      expect(lowest_zero_prefix_number("pqrstuv", 5)).to eq 1048970
    end

    it "works on the input given" do
      expect(lowest_zero_prefix_number("iwrupvqb", 5)).to eq 346386
    end
  end

  context "six zeroes" do
    it "works on the input given" do
      expect(lowest_zero_prefix_number("iwrupvqb", 6)).to eq 9958218
    end
  end
end
