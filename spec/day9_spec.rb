require 'spec_helper.rb'

describe "day9" do
  context "shortest path" do
    it "works on the example provided" do
      lines = File.readlines("data/input9a.txt").map(&:strip)
      graph = parse_day9_lines(lines, 2 ** 31)
      expect(shortest_path(graph)).to eq 605
    end

    it "works on the input file" do
      lines = File.readlines("data/input9.txt").map(&:strip)
      graph = parse_day9_lines(lines, 2 ** 31)
      expect(shortest_path(graph)).to eq 117
    end
  end

  context "longest path" do
    it "works on the example provided" do
      lines = File.readlines("data/input9a.txt").map(&:strip)
      graph = parse_day9_lines(lines, 0)
      expect(longest_path(graph)).to eq 982
    end

    it "works on the input file" do
      lines = File.readlines("data/input9.txt").map(&:strip)
      graph = parse_day9_lines(lines, 0)
      expect(longest_path(graph)).to eq 909
    end
  end
end
