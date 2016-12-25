line = File.read_lines("data/1.txt").first

directions = line.split(",").map(&.strip)
#directions = ["R5", "L5", "R5", "R3"]

x_distance = 0
y_distance = 0

direction_orientations = [1, 1, -1, -1]
current_direction = 1
vertical = true

vertical_sum = 0
horizontal_sum = 0

directions.each do |d|
  vertical = !vertical

  if d[0] == 'R'
    current_direction -= 1
  else
    current_direction += 1
  end

  current_direction %= 4

  distance = direction_orientations[current_direction] * d[1..-1].to_i
  if vertical
    vertical_sum += distance
  else
    horizontal_sum += distance
  end
end

puts vertical_sum.abs + horizontal_sum.abs
