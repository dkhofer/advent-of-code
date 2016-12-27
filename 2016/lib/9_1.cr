def decompress(text)
  i = 0
  new_text = [] of String
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
      parts.last.to_i.times do
        new_text << string_to_copy
      end
    else
      new_text << text[i].to_s
    end

    i += 1
  end

  new_text.join.size
end

#puts decompress("ADVENT")
#puts decompress("A(1x5)BC")
#puts decompress("(3x3)XYZ")
#puts decompress("A(2x2)BCD(2x2)EFG")
#puts decompress("(6x1)(1x3)A")
#puts decompress("X(8x2)(3x3)ABCY")

lines = File.read_lines("data/9.txt").map(&.strip).join

puts decompress(lines)
