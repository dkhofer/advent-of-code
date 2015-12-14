require 'spec_helper.rb'

describe "day 14" do
  context "part 1" do
    it "calculates distance for the sample inputs provided" do
      reindeer_list = [
        "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.",
        "Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.",
      ]

      expect(get_max_reindeer_distance(reindeer_list, 1000)).to eq 1120
    end

    it "calculates distance for the input file given" do
      reindeer_list = File.readlines("data/input14.txt").map(&:strip)
      expect(get_max_reindeer_distance(reindeer_list, 2503)).to eq 2660
    end
  end

  context "part 2" do
    it "calculates scores for the sample inputs provided" do
      reindeer_list = [
        "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.",
        "Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.",
      ]

      expect(get_max_reindeer_points(reindeer_list, 1000)).to eq 689
    end

    it "calculates scores for the input file given" do
      reindeer_list = File.readlines("data/input14.txt").map(&:strip)
      expect(get_max_reindeer_points(reindeer_list, 2503)).to eq 1256
    end
  end
end
