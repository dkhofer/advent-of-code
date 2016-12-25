lines = File.read_lines("data/3.txt")

def triangle?(line)
  sides = line.strip.split(/\s+/).map(&.to_i).sort
  sides[0..1].sum > sides.last
end

#puts triangle?("5 10 25")
#puts triangle?("3 4 5")

puts lines.select { |line| triangle?(line) }.size
