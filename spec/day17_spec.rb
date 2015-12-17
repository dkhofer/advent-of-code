require 'spec_helper.rb'

describe "day 17" do
  context "part 1" do
    it "works on the sample input given" do
      containers = [20, 15, 10, 5, 5]
      expect(find_container_combinations(containers, 25)).to eq 4
    end

    it "works on the input file given" do
      containers = File.readlines("data/input17.txt").map(&:strip).map(&:to_i)
      expect(find_container_combinations(containers, 150)).to eq 4372
    end
  end

  context "part 2" do
    it "works on the sample input given" do
      containers = [20, 15, 10, 5, 5]
      expect(find_min_container_combinations(containers, 25)).to eq 3
    end

    it "works on the input file given" do
      containers = File.readlines("data/input17.txt").map(&:strip).map(&:to_i)
      expect(find_min_container_combinations(containers, 150)).to eq 4
    end
  end
end
