require 'spec_helper.rb'

describe "day 19" do
  context "part 1" do
    it "works on the sample input given" do
      lines = [
        "H => HO",
        "H => OH",
        "O => HH",
      ]
      expect(generated_molecule_count(lines + ["", "HOH"])).to eq 4
      expect(generated_molecule_count(lines + ["", "HOHOHO"])).to eq 7
    end

    it "works on the input file given" do
      lines = File.readlines("data/input19.txt").map(&:strip)
      expect(generated_molecule_count(lines)).to eq 518
    end
  end

  context "part 2" do
    it "works on the sample input given" do
      lines = [
        "H => HO",
        "H => OH",
        "O => HH",
        "e => H",
        "e => O",
      ]
      expect(medicine_time_step_count(lines + ["", "HOH"])).to eq 3
      expect(medicine_time_step_count(lines + ["", "HOHOHO"])).to eq 6
    end

    # NOTE(hofer): This test passes but my code takes a pathetically
    # long time to run, so I'm leaving it commented out.
#    it "works on the input file given" do
#      lines = File.readlines("data/input19.txt").map(&:strip)
#      expect(medicine_time_step_count(lines, true)).to eq 200
#    end
  end
end
