def generated_molecule_count(lines)
  rules, molecule = parse_rules_and_molecule(lines)
  iterate_molecule(molecule, rules).count
end

def iterate_molecule(molecule, rules)
  result = rules.keys.reduce(Set.new) do |molecules, rule_match|
    (0..molecule.size-1).map do |i|
      if molecule[i..i+rule_match.length-1] == rule_match
        rules[rule_match].map do |replacement|
          new_molecule = molecule.dup
          new_molecule[i..i+rule_match.length-1] = replacement
          molecules.add(new_molecule)
        end
      end
    end
    molecules
  end

  result
end

def parse_rules_and_molecule(lines)
  rules = lines[0..-3].reduce(Hash.new) do |current_rules, line|
    components = line.split(" => ")
    current_rules[components[0]] ||= Set.new
    current_rules[components[0]].add(components[1])
    current_rules
  end
  [rules, lines[-1]]
end

def inverse_rule_match(molecule, inverse_rules)
  inverse_rules.keys.each do |key|
    return key if (key =~ /^.*Ar$/) && molecule =~ Regexp.new(key)
  end

  inverse_rules.keys.each do |key|
    result = inverse_rules[key].first
    if result =~ /Ca/ || key =~ /Ti/
      if (key =~ Regexp.new("^.+#{result}$") ||
          key =~ Regexp.new("^#{result}.+$")) &&
          molecule =~ Regexp.new(key)
        return key
      end
    end
  end

  return nil
end

def reduce_molecule(molecule, inverse_rules)
  key = inverse_rule_match(molecule, inverse_rules)
  time_steps = 0
  while !key.nil?
    parts = molecule.split(key)
    time_steps += parts.size - 1
    molecule = parts.join(inverse_rules[key].first)

    key = inverse_rule_match(molecule, inverse_rules)
  end

  return [molecule, time_steps]
end

# NOTE(hofer): I noticed that some rule results are terminal or reduce
# to simpler rules.  I'm using that to work backwards here.
def medicine_time_step_count(lines, use_optimizations = false)
  inverse_rules, target_molecule = parse_inverse_rules_and_molecule(lines)
  find_minimal_time_steps(target_molecule, inverse_rules, use_optimizations)
end

def min_length(list)
  list.reduce(2 ** 30) { |current_min, element| element.size < current_min ? element.size : current_min }
end

def find_minimal_time_steps(target_molecule, inverse_rules, use_optimizations = false)
  time_steps = 0
  iterated_molecules = Set.new([target_molecule])

  time_steps_by_molecule = Hash.new(0)
  parents_by_molecule = {}

  while !iterated_molecules.include?("e") && !iterated_molecules.empty?
    new_molecules = Set.new
    iterated_molecules.each do |molecule|

      if use_optimizations
        new_molecule, reducing_time_steps = reduce_molecule(molecule, inverse_rules)
        time_steps_by_molecule[new_molecule] = reducing_time_steps + time_steps_by_molecule[molecule]
        parents_by_molecule[new_molecule] = molecule
        molecule = new_molecule
      end

      next_molecules = iterate_molecule(molecule, inverse_rules).reject { |temp_molecule| temp_molecule =~ /e/ && temp_molecule != "e" }
      next_molecules.each do |next_molecule|
        time_steps_by_molecule[next_molecule] = 1 + time_steps_by_molecule[molecule]
        parents_by_molecule[next_molecule] = molecule
      end
      new_molecules.merge(next_molecules)
    end

    min_molecule_length = min_length(new_molecules)
    iterated_molecules = new_molecules.select { |molecule| molecule.size <= min_molecule_length + 2 }
  end

  return time_steps_by_molecule["e"]
end

def parse_inverse_rules_and_molecule(lines)
  rules = lines[0..-3].reduce(Hash.new) do |current_rules, line|
    components = line.split(" => ")
    current_rules[components[1]] = Set.new([components[0]])
    current_rules
  end
  [rules, lines[-1]]
end
