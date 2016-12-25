require 'spec_helper.rb'

describe "day11" do
  it "tests password validity" do
    expect(password_valid?("hijklmmn")).to eq false
    expect(password_valid?("abbceffg")).to eq false
    expect(password_valid?("abbcegjk")).to eq false
    expect(password_valid?("iabdeghk")).to eq false
    expect(password_valid?("abcdffaa")).to eq true
    expect(password_valid?("ghjaabcc")).to eq true
  end

  it "gets the next valid password" do
    expect(next_password("abcdefgh")).to eq "abcdffaa"
    expect(next_password("ghjaaaaa")).to eq "ghjaabcc"
    expect(next_password("hxbxwxba")).to eq "hxbxxyzz"
    expect(next_password("hxbxxyzz")).to eq "hxcaabcc"
  end
end
