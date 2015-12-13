def maximal_seating_happiness(happiness_list, include_me = false)
  find_maximal_happiness(parse_list(happiness_list, include_me))
end

def parse_list(happiness_list, include_me)
  graph = {}
  happiness_list.each do |line|
    parts = line.split
    name1 = parts[0]
    name2 = parts[-1][0..-2]
    units = parts[3].to_i
    units = -units if parts[2] == "lose"
    graph[[name1, name2]] = units
  end

  if include_me
    names = graph.keys.flatten
    names.each do |name|
      graph[[name, "David H"]] = 0
      graph[["David H", name]] = 0
    end
  end

  graph
end

def find_maximal_happiness(graph)
  names = graph.keys.flatten.uniq
  names.permutation.reduce(0) do |current_max, names|
    happiness = names.zip(names.rotate).reduce(0) { |sum, key| sum + graph[key] + graph[key.reverse] }
    happiness > current_max ? happiness : current_max
  end
end
