line = File.read_lines("data/1.txt").first

directions = line.split(",").map(&.strip)
#directions = ["R8", "R4", "R4", "R8"]

x_distance = 0
y_distance = 0

direction_orientations = [1, 1, -1, -1]
current_direction = 1
vertical = true

vertical_sum = 0
horizontal_sum = 0

locations = Set({Int32, Int32}).new

directions.each do |d|
  vertical = !vertical

  if d[0] == 'R'
    current_direction -= 1
  else
    current_direction += 1
  end

  current_direction %= 4

  distance = direction_orientations[current_direction] * d[1..-1].to_i
  start = 0
  stop = distance

  start, stop = stop, start if stop < start

  if vertical
    (start...stop).to_a.each do |i|
      next if i == 0
      if locations.includes?({horizontal_sum, vertical_sum + i})
        puts (vertical_sum + i).abs + horizontal_sum.abs
        exit
      else
        locations << {horizontal_sum, vertical_sum + i}
      end
    end

    vertical_sum += distance
  else
    (start...stop).to_a.each do |i|
      next if i == 0
      if locations.includes?({horizontal_sum + i, vertical_sum})
        puts (horizontal_sum + i).abs + vertical_sum.abs
        exit
      else
        locations << {horizontal_sum + i, vertical_sum}
      end
    end
    horizontal_sum += distance
  end
end
