def day3(filename)
  moves = File.readlines(filename).first.strip.split("")
  puts house_count(moves)
  puts robo_house_count(moves)
end

def house_count(moves)
  location = [0,0]
  houses = Hash.new(false)
  houses[location] = true

  moves.each do |move|
    location = update_location(move, location)
    houses[location] = true
  end

  houses.size
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

def robo_house_count(moves)
  santa_location = robo_location = [0,0]
  houses = Hash.new(false)
  houses[santa_location] = true

  moves.each_with_index do |move, i|
    if i % 2 == 0
      santa_location = update_location(move, santa_location)
      houses[santa_location] = true
    else
      robo_location = update_location(move, robo_location)
      houses[robo_location] = true
    end
  end

  houses.size
end
