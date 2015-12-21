require 'spec_helper.rb'

describe "day 20" do
  context "part 1" do
    it "works on a sample fight" do
      my_stats = [8, 5, 5]
      boss_stats = [12, 7, 2]
      expect(fight_result(my_stats, boss_stats)).to eq :me
    end

    it "works for the stats given" do
      # NOTE(hofer): Not going to bother parsing this out of the input file.
      boss_stats = [109, 8, 2]
      # NOTE(hofer): Embarrassingly, I was able to eyeball the costs
      # and guess what the minimum would be.
      my_stats = [100, 7, 4]
      expect(fight_result(my_stats, boss_stats)).to eq :me
    end
  end

  context "part 2" do
    it "works for the stats given" do
      # NOTE(hofer): Not going to bother parsing this out of the input file.
      boss_stats = [109, 8, 2]
      # NOTE(hofer): Again, embarrassingly, I was able to eyeball the
      # costs and guess what the maximum would be.
      my_stats = [100, 7, 3]
      expect(fight_result(my_stats, boss_stats)).to eq :boss
    end
  end
end
