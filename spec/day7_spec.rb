require 'spec_helper.rb'

describe "day7" do
  def expect_circuit(circuit, wire, value)
  end

  context "part 1" do
    it "evaluates a sample circuit correctly" do
      lines = [
        "123 -> x",
        "456 -> y",
        "x AND y -> d",
        "x OR y -> e",
        "x LSHIFT 2 -> f",
        "y RSHIFT 2 -> g",
        "NOT x -> h",
        "NOT y -> i",
      ]

      circuit = parse_lines(lines)
      circuit_values = process_circuit(circuit)
      expect(circuit_values["x"]).to eq 123
      expect(circuit_values["y"]).to eq 456
      expect(circuit_values["d"]).to eq 72
      expect(circuit_values["e"]).to eq 507
      expect(circuit_values["f"]).to eq 492
      expect(circuit_values["g"]).to eq 114
      expect(circuit_values["h"]).to eq 65412
      expect(circuit_values["i"]).to eq 65079
    end

    it "evaluates ANDs" do
      circuit = parse_lines([
                              "1 -> x",
                              "2 -> y",
                              "x OR y -> z",
                              "z -> a",
                              ])
      circuit_values = process_circuit(circuit)
      expect(circuit_values["x"]).to eq 1
      expect(circuit_values["y"]).to eq 2
      expect(circuit_values["z"]).to eq 3
      expect(circuit_values["a"]).to eq 3
    end

    it "evaluates the input file correctly" do
      lines = File.readlines("data/input7.txt").map(&:strip)
      circuit = parse_lines(lines)
      circuit_values = process_circuit(circuit)
      expect(circuit_values["a"]).to eq 16076
    end
  end
end
