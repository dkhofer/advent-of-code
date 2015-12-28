def day7(filename)
  lines = File.readlines(filename).map(&:strip)
  circuit = parse_lines(lines)
  circuit_values = process_circuit(circuit)
  return circuit_values["a"]
end

def parse_lines(lines)
  circuit = {}
  lines.each do |line|
    mapping = line.split(" -> ").reverse
    circuit[mapping[0]] = mapping[1]
  end

  circuit
end

def contains_evaluations(wires, evaluated)
  wires.each { |wire| return false if evaluated[wire] == :unevaluated }
  return true
end

def process_circuit(circuit)
  evaluated = {}
  circuit.keys.each { |key| evaluated[key] = :unevaluated }

  while evaluated.values.include? :unevaluated do
    circuit.keys.each do |key|
      if circuit[key] =~ /^\d+$/
        evaluated[key] = circuit[key].to_i
      elsif circuit[key] =~ /^\w+$/
        if evaluated[circuit[key]] != :unevaluated
          evaluated[key] = evaluated[circuit[key]]
        end
      elsif evaluated[key] == :unevaluated
        operation = circuit[key].split
        op_type = operation[-2]

        if operation[0] =~ /^\d+$/
          evaluated[operation[0]] = operation[0].to_i
        end

        if operation[1] =~ /^\d+$/
          evaluated[operation[1]] = operation[1].to_i
        end

        if operation[2] =~ /^\d+$/
          evaluated[operation[2]] = operation[2].to_i
        end

        case op_type
        when "AND"
          if contains_evaluations([operation[0], operation[2]], evaluated)
            evaluated[key] = evaluated[operation[0]] & evaluated[operation[2]]
          end
        when "OR"
          if contains_evaluations([operation[0], operation[2]], evaluated)
            evaluated[key] = evaluated[operation[0]] | evaluated[operation[2]]
          end
        when "LSHIFT"
          if contains_evaluations([operation[0]], evaluated)
            evaluated[key] = evaluated[operation[0]] << operation[2].to_i
          end
        when "RSHIFT"
          if contains_evaluations([operation[0]], evaluated)
            evaluated[key] = evaluated[operation[0]] >> operation[2].to_i
          end
        when "NOT"
          if contains_evaluations([operation[1]], evaluated)
            evaluated[key] = ~evaluated[operation[1]]
          end
        else
          raise "Unknown op type: #{op_type}"
        end

        evaluated[key] &= 0xFFFF unless evaluated[key] == :unevaluated
      end
    end
  end

  return evaluated
end
