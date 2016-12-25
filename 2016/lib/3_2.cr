lines = File.read_lines("data/3.txt")

triples = Array(Array(String)).new

lines.each_slice(3) do |lines|
  rows = lines.map { |line| line.strip.split(/\s+/) }
  (0..2).to_a.each { |i| triples << rows.map { |row| row[i] } }
end

def triangle?(triple)
  sides = triple.map(&.to_i).sort
  sides[0..1].sum > sides.last
end

puts triples.select { |triple| triangle?(triple) }.size
