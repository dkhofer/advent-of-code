def day2(filename)
  boxes = File.readlines(filename).map(&:strip).map { |line| line.split("x").map(&:to_i) }
  puts wrapping_paper(boxes)
  puts ribbon(boxes)
end

def wrapping_paper(boxes)
  boxes.reduce(0) do |sum, box|
    area1 = box[0] * box[1]
    area2 = box[0] * box[2]
    area3 = box[1] * box[2]
    sum + (2 * (area1 + area2 + area3)) + [area1,area2,area3].min
  end
end

def ribbon(boxes)
  boxes.reduce(0) do |sum, box|
    perimeter1 = 2 * (box[0] + box[1])
    perimeter2 = 2 * (box[0] + box[2])
    perimeter3 = 2 * (box[1] + box[2])

    sum + [perimeter1,perimeter2,perimeter3].min + box.reduce(&:*)
  end
end
