require 'spec_helper.rb'

describe "day8" do
  context "escape overhead" do
    it "works on provided examples" do
      expect(escape_overhead("")).to eq 2
      expect(escape_overhead("abc")).to eq 2
      expect(escape_overhead("aaa\\\"aaa")).to eq 3
      expect(escape_overhead("\\x27")).to eq 5
    end

    context "input given" do
      it "works on one line" do
        line = File.readlines("data/input8a.txt").first.strip
        expect(escape_overhead(line)).to eq 7
      end

      it "works on another line" do
        line = File.readlines("data/input8b.txt").first.strip
        expect(escape_overhead(line)).to eq 4
      end

      it "works with all hex escape digits" do
        line = File.readlines("data/input8c.txt").first.strip
        expect(escape_overhead(line)).to eq 7
      end

      it "works with an escaped backslash at the end" do
        line = File.readlines("data/input8d.txt").first.strip
        expect(escape_overhead(line)).to eq 3
      end

      it "works on the full file" do
        lines = File.readlines("data/input8.txt").map(&:strip)
        escape_count = lines.reduce(0) { |sum, line| sum + escape_overhead(line) }
        expect(escape_count).to eq 1350
      end
    end
  end

  context "escaped escape overhead" do
    it "works on one line" do
      line = File.readlines("data/input8a.txt").first.strip
      expect(escaped_escape_overhead(line)).to eq 9
    end

    it "works on another line" do
      line = File.readlines("data/input8b.txt").first.strip
      expect(escaped_escape_overhead(line)).to eq 8
    end

    it "works with all hex escape digits" do
      line = File.readlines("data/input8c.txt").first.strip
      expect(escaped_escape_overhead(line)).to eq 9
    end

    it "works with an escaped backslash at the end" do
      line = File.readlines("data/input8d.txt").first.strip
      expect(escaped_escape_overhead(line)).to eq 6
    end

    it "works on the full file" do
      lines = File.readlines("data/input8.txt").map(&:strip)
      escape_count = lines.reduce(0) { |sum, line| sum + escaped_escape_overhead(line) }
      expect(escape_count).to eq 2085
    end
  end
end
