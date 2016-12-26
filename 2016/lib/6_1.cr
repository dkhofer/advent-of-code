# strings = %w{
#   eedadn
#   drvtee
#   eandsr
#   raavrd
#   atevrs
#   tsrnev
#   sdttsa
#   rasrtv
#   nssdts
#   ntnada
#   svetve
#   tesnvt
#   vntsnd
#   vrdear
#   dvrsen
#   enarar
# }

strings = File.read_lines("data/6.txt").map(&.strip)

string_size = strings.first.size

chars = (0...string_size).map do |i|
  char_counts = Hash(Char, Int32).new(0)
  strings.each { |s| char_counts[s[i]] += 1 }
  char_counts.keys.map { |key| {key, char_counts[key]} }.sort_by(&.last).last.first
end

puts chars.join
