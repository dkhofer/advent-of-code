def lit_count(lines, steps, print_grid = false, four_corners = false)
  grid = parse_light_lines(lines)
  n = lines.size
  if four_corners
    grid[[0,0]] = grid[[0,n-1]] = grid[[n-1,0]] = grid[[n-1,n-1]] = 1
  end

  print_light_grid(grid, n) if print_grid

  steps.times do
    grid = evaluate_lights(grid, n, four_corners)
    if print_grid
      puts "-------------------------------"
      print_light_grid(grid, n)
    end
  end

  lights_on(grid, n)
end

def print_light_grid(grid, n)
  (0..n-1).map do |i|
    puts (0..n-1).map { |j| grid[[i,j]] == 0 ? "." : "#" }.join
  end
end

def parse_light_lines(lines)
  (0..lines.size-1).reduce(Hash.new(0)) do |grid, i|
    lights = lines[i].split("").map { |c| c == "." ? 0 : 1 }
    lights.each_with_index { |light, j| grid[[i,j]] = light }
    grid
  end
end

def evaluate_lights(grid, n, four_corners)
  (0..n-1).reduce(Hash.new(0)) do |new_grid, i|
    (0..n-1).each do |j|
      new_grid[[i, j]] = new_light_value(grid, i, j, n, four_corners)
    end
    new_grid
  end
end

def new_light_value(grid, i, j, n, four_corners)
  count = neighbor_count(grid, i, j)
  if count == 3 ||
    (grid[[i,j]] == 1 && count == 2) ||
      (four_corners && [0,n-1].include?(i) && [0,n-1].include?(j))
    1
  else
    0
  end
end

def neighbor_count(grid, i, j)
  (i-1..i+1).reduce(0) do |sum, x|
    sum + (j-1..j+1).reduce(0) do |sum2, y|
      sum2 + ((x == i && y == j) ? 0 : grid[[x,y]])
    end
  end
end

def lights_on(grid, n)
  (0..n-1).reduce(0) do |sum, i|
    sum + (0..n-1).reduce(0) do |sum2, j|
      sum2 + grid[[i,j]]
    end
  end
end
