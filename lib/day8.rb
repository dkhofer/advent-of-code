def day8(filename)
  lines = File.readlines("data/input8.txt").map(&:strip)
  puts "Part 1: #{lines.reduce(0) { |sum, line| sum + escape_overhead(line) }}"
  puts "Part 2: #{lines.reduce(0) { |sum, line| sum + escaped_escape_overhead(line) }}"
end

def escape_overhead(escaped_string)
  result = 2
  result += escaped_string.scan(/\\\\/).size
  result += escaped_string.scan(/\\"/).size
  result += escaped_string.scan(/\\x[a-f0-9]{2}/).size * 3
  # NOTE(hofer): Edge case: Escaped backslash at end of line, don't count \" separately
  result -= 1 if escaped_string =~ /\\"$/

  result
end

def escaped_escape_overhead(escaped_string)
  result = 2 # For backslashes that will escape the surrounding escaped quotes
  result += escaped_string.scan(/\\/).size
  result += escaped_string.scan(/\"/).size # Includes surrounding quotes that get escaped

  result
end
