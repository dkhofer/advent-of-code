def day6(filename)
  lines = File.readlines(filename).map(&:strip)
  count_lights(parse_rectangles(lines), :part1)
  count_lights(parse_rectangles(lines), :part2)
end

def parse_rectangles(lines)
  lines.map do |line|
    if line.start_with? "turn on"
      words = line.split(" ")
      start = words[2].split(",").map(&:to_i)
      finish = words[4].split(",").map(&:to_i)
      [start, finish, :on]
    elsif line.start_with? "turn off"
      words = line.split(" ")
      start = words[2].split(",").map(&:to_i)
      finish = words[4].split(",").map(&:to_i)
      [start, finish, :off]
    elsif line.start_with? "toggle"
      words = line.split(" ")
      start = words[1].split(",").map(&:to_i)
      finish = words[3].split(",").map(&:to_i)
      [start, finish, :toggle]
    else
      raise "Unknown instruction: #{line}"
    end
  end
end

def count_lights(rectangles, part)
  # Initialize.
  grid = []
  (0..999).each do |x|
    grid[x] = []
    (0..999).each do |y|
      grid[x][y] = 0
    end
  end

  # Apply the rules.
  rectangles.each do |rectangle|
    (rectangle[0].first..rectangle[1].first).each do |x|
      (rectangle[0].last..rectangle[1].last).each do |y|
        apply_rule(rectangle, grid, x, y, part)
      end
    end
  end

  # Count the lights.
  count = 0
  (0..999).each do |x|
    (0..999).each do |y|
      count += grid[x][y]
    end
  end

  count
end

def apply_rule(rectangle, grid, x, y, part)
  if rectangle[2] == :on
    if part == :part1
      grid[x][y] = 1
    else
      grid[x][y] += 1
    end
  elsif rectangle[2] == :off
    if part == :part1
      grid[x][y] = 0
    else
      grid[x][y] -= 1
      grid[x][y] = 0 if grid[x][y] < 0
    end
  elsif rectangle[2] == :toggle
    if part == :part1
      grid[x][y] = 1 - grid[x][y]
    else
      grid[x][y] += 2
    end
  else
    raise "Unknown instruction: #{rectangle[2]}"
  end
end
