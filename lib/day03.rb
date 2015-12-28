def day3(filename)
  moves = File.readlines(filename).first.strip.split("")
  puts house_count(moves)
  puts robo_house_count(moves)
end

def house_count(moves)
  houses_visited(moves).uniq.size
end

def update_location(move, location)
  if move == "^"
    [location.first, location.last + 1]
  elsif move == ">"
    [location.first + 1, location.last]
  elsif move == "v"
    [location.first, location.last - 1]
  elsif move == "<"
    [location.first - 1, location.last]
  else
    raise "Unknown move: #{move}"
  end
end

def houses_visited(moves)
  moves.reduce([[0,0]]) do |locations, move|
    locations << update_location(move, locations.last)
  end
end

def robo_house_count(moves)
  moves_with_indices = moves.zip((0...moves.length).to_a)
  santa_moves, robo_moves = moves_with_indices.partition { |parts| parts[1].even? }
  (houses_visited(santa_moves.map(&:first)) + houses_visited(robo_moves.map(&:first))).uniq.size
end
