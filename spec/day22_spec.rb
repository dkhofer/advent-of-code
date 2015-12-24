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
      winner, mana_spent = magic_fight_result(my_stats, boss_stats)
      expect(winner).to eq :me
      expect(mana_spent).to eq 10000
    end
  end
end
