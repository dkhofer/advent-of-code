def day9(filename)
  lines = File.readlines("data/input9.txt").map(&:strip)
  short_graph = parse_day9_lines(lines, 2 ** 31)
  long_graph = parse_day9_lines(lines, 0)
  puts "Shortest path: #{shortest_path(graph)}"
  puts "Longest path: #{longest_path(graph)}"
end

def parse_day9_lines(lines, default_distance)
  lines.reduce(Hash.new(default_distance)) do |graph, line|
    parts = line.split
    city1 = parts[0]
    city2 = parts[2]
    distance = parts[4]
    graph[[city1, city2]] = distance.to_i
    graph[[city2, city1]] = distance.to_i
    graph
  end
end

def path_lengths(graph)
  places = graph.keys.flatten.uniq
  places.permutation.map do |permuted_places|
    path = permuted_places[0..-2].zip(permuted_places[1..-1])
    path.reduce(0) { |sum, edge| sum + graph[edge] }
  end
end

def shortest_path(graph)
  path_lengths(graph).reduce(2 ** 31) { |current_min, distance| distance < current_min ? distance : current_min }
end

def longest_path(graph)
  path_lengths(graph).reduce(0) { |current_max, distance| distance > current_max ? distance : current_max }
end
