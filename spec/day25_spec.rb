require 'spec_helper.rb'

describe "day 25" do
  context "part 1" do
    it "works on the sample input" do
      expect(find_weather_code(1, 2)).to eq 18749137
      expect(find_weather_code(6, 6)).to eq 27995004
    end

    it "works on the real input" do
      expect(find_weather_code(2978, 3083)).to eq 2650453
    end
  end
end
