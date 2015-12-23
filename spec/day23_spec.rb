require 'spec_helper.rb'

describe "day 23" do
  context "part 1" do
    it "works on the sample input" do
      lines = [
        "inc a",
        "jio a, +2",
        "tpl a",
        "inc a",
      ]
      a, b = run_program(lines)
      expect(a).to eq 2
    end

    it "works on the input file" do
      lines = File.readlines("data/input23.txt").map(&:strip)
      a, b = run_program(lines)
      expect(b).to eq 255
    end
  end

  context "part 2" do
    it "works on the input file" do
      lines = File.readlines("data/input23.txt").map(&:strip)
      a, b = run_program(lines, 1)
      expect(b).to eq 334
    end
  end
end
