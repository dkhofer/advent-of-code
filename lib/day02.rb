def day2(filename)
  boxes = File.readlines(filename).map(&:strip).map { |line| line.split("x").map(&:to_i) }
  puts wrapping_paper(boxes)
  puts ribbon(boxes)
end

def wrapping_paper(boxes)
  boxes.reduce(0) do |sum, box|
    areas = box.combination(2).map { |dimensions| dimensions.reduce(&:*) }
    sum + (2 * (areas.reduce(&:+))) + areas.min
  end
end

def ribbon(boxes)
  boxes.reduce(0) do |sum, box|
    perimeters = box.combination(2).map { |dimensions| 2 * dimensions.reduce(&:+) }
    sum + perimeters.min + box.reduce(&:*)
  end
end
