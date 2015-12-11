require 'spec_helper.rb'

describe "day10" do
  it "iterates correctly" do
    expect(iterate_numbers("1")).to eq "11"
    expect(iterate_numbers("11")).to eq "21"
    expect(iterate_numbers("21")).to eq "1211"
    expect(iterate_numbers("1211")).to eq "111221"
    expect(iterate_numbers("111221")).to eq "312211"
  end

  it "iterates 40 times correctly" do
    result = "1113122113"
    40.times do
      result = iterate_numbers(result)
    end
    expect(result.length).to eq 360154
  end

  it "iterates 50 times correctly" do
    result = "1113122113"
    50.times do
      result = iterate_numbers(result)
    end
    expect(result.length).to eq 5103798
  end

end
