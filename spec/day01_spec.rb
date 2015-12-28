require 'spec_helper.rb'

describe "day1" do
  def expect_parens(parens, floor, position)
    expect(process_parens(parens.split(""))).to eq [floor, position]
  end

  it "works on provided examples" do
    expect_parens("(())", 0, nil)
    expect_parens("()()", 0, nil)
    expect_parens("(((", 3, nil)
    expect_parens("(()(()(", 3, nil)
    expect_parens("))(((((", 3, 1)
    expect_parens("())", -1, 3)
    expect_parens("))(", -1, 1)
    expect_parens(")))", -3, 1)
    expect_parens(")())())", -3, 1)
  end

  it "works on the input file" do
    parens = File.readlines("data/input1.txt").first.strip
    expect_parens(parens, 280, 1797)
  end
end
