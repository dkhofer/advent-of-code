require 'spec_helper.rb'

describe "day 24" do
  context "part 1" do
    it "works on the sample input" do
      packages = [
        1,
        2,
        3,
        4,
        5,
        7,
        8,
        9,
        10,
        11,
      ].map(&:to_s)
      expect(find_optimal_passenger_seat_packages(packages)).to eq 99
    end

    it "works on the input file" do
      packages = File.readlines("data/input24.txt").map(&:strip)
      expect(find_optimal_passenger_seat_packages(packages)).to eq 11846773891
    end
  end

  context "part 2" do
    it "works on the sample input" do
      packages = [
        1,
        2,
        3,
        4,
        5,
        7,
        8,
        9,
        10,
        11,
      ].map(&:to_s)
      expect(find_optimal_passenger_seat_packages(packages, 4)).to eq 44
    end

    it "works on the input file" do
      packages = File.readlines("data/input24.txt").map(&:strip)
      expect(find_optimal_passenger_seat_packages(packages, 4)).to eq 80393059
    end
  end
end
