require "big_int"

def decompress(text)
  i = 0
  multiplier = 1
  char_count = BigInt.new(0)

  until i == text.size
    if text[i] == '('
      start = i + 1
      until text[i] == ')'
        i += 1
      end

      parts = text[start...i].split("x")
      chars_to_copy = [] of String
      parts.first.to_i.times do
        i += 1
        chars_to_copy << text[i].to_s
      end

      string_to_copy = chars_to_copy.join
      char_count += parts.last.to_i * decompress(string_to_copy)
    else
      char_count += 1
    end

    i += 1
  end

  char_count
end

#puts decompress("(3x3)XYZ")
#puts decompress("X(8x2)(3x3)ABCY")
#puts decompress("(27x12)(20x12)(13x14)(7x10)(1x12)A")
#puts decompress("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN")

lines = File.read_lines("data/9.txt").map(&.strip).join

puts decompress(lines)
