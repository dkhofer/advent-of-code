CRITERIA = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1,
}

def find_matching_sue(lines)
  sues = parse_sues(lines)
  sues.select(&method(:sue_match?)).first[:number].to_i
end

def find_real_matching_sue(lines)
  sues = parse_sues(lines)
  sues.select(&method(:real_sue_match?)).first[:number].to_i
end

def parse_sues(lines)
  lines.map do |line|
    parts = line.split(": ")
    number = parts.first.split.last
    rest = parts[1..-1].join(": ")
    attribute_list = rest.split(", ").map { |element| element.split(": ") }
    attributes = { "number": number }
    attribute_list.each { |pair| attributes[pair[0].to_sym] = pair[1].to_i }
    attributes
  end
end

def sue_match?(sue)
  sue.keys.reduce(true) do |is_match, key|
    if key == :number
      is_match
    else
      is_match && (CRITERIA[key] == sue[key])
    end
  end
end

def real_sue_match?(sue)
  sue.keys.reduce(true) do |is_match, key|
    if key == :number
      is_match
    elsif [:cats, :trees].include?(key)
      is_match && (CRITERIA[key] < sue[key])
    elsif [:pomeranians, :goldfish].include?(key)
      is_match && (CRITERIA[key] > sue[key])
    else
      is_match && (CRITERIA[key] == sue[key])
    end
  end
end
