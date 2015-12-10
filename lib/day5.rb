def day5(filename)
  words = File.readlines(filename).map(&:strip)
  words.count(&method(:nice_word)).size
end

def part1_nice_word(word)
  !(word =~ /(.*[aeiou].*){3}/).nil? &&
    !(word =~ /(\w)\1+/).nil? &&
    (word =~ /(ab|cd|pq|xy)/).nil?
end

def part2_nice_word(word)
  !(word =~ /(\w\w).*\1/).nil? &&
    !(word =~ /(\w)\w\1/).nil?
end
