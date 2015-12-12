require 'spec_helper.rb'

describe "day12" do
  context "part 1" do
    it "sums numbers in the examples given" do
      expect(sum_json_numbers("[1,2,3]")).to eq 6
      expect(sum_json_numbers("{\"a\":2,\"b\":4}")).to eq 6
      expect(sum_json_numbers("[[[3]]]")).to eq 3
      expect(sum_json_numbers("{\"a\":{\"b\":4},\"c\":-1}")).to eq 3
      expect(sum_json_numbers("{\"a\":[-1,1]}")).to eq 0
      expect(sum_json_numbers("[-1,{\"a\":1}]")).to eq 0
      expect(sum_json_numbers("[]")).to eq 0
      expect(sum_json_numbers("{}")).to eq 0
    end

    it "sums numbers in the input given" do
      line = File.readlines("data/input12.txt").first.strip
      expect(sum_json_numbers(line)).to eq 119433
    end
  end

  context "part 2" do
    it "sums numbers in the examples given" do
      expect(sum_json_numbers("[1,2,3]", true)).to eq 6
      expect(sum_json_numbers("[1,{\"c\":\"red\",\"b\":2},3]", true)).to eq 4
      expect(sum_json_numbers("{\"d\":\"red\",\"e\":[1,2,3,4],\"f\":5}", true)).to eq 0
      expect(sum_json_numbers("[1,\"red\",5]", true)).to eq 6
    end

    it "sums numbers in the input given" do
      line = File.readlines("data/input12.txt").first.strip
      expect(sum_json_numbers(line, true)).to eq 68466
    end
  end
end
