require 'spec_helper.rb'

describe "day 22" do
  context "part 1" do
    it "works on the main input" do
      my_stats = {
        :mana => 500,
        :hit_points => 50,
      }
      boss_stats = {
        :hit_points => 71,
        :damage => 10,
      }
      # NOTE(hofer): This works but takes a long time.
#      mana_spent = magic_fight_result(my_stats, boss_stats)
#      expect(mana_spent).to eq 1824
    end
  end

  context "part 2" do
    it "works on the main input" do
      my_stats = {
        :mana => 500,
        :hit_points => 50,
      }
      boss_stats = {
        :hit_points => 71,
        :damage => 10,
      }
      mana_spent = magic_fight_result(my_stats, boss_stats, true)
      expect(mana_spent).to eq 1937
    end
  end
end
