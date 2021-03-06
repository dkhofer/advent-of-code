lines = File.read_lines("data/4.txt")

def valid?(line)
  parts = line.strip.split("[")
  checksum = parts.last[0..-2]
  first_parts = parts.first.split("-")
  letters = first_parts[0..-2].join("").split("")

  letter_groups = letters.group_by { |letter| letter }
  letter_counts = Hash(String, Int32).new
  letter_groups.keys.each { |letter| letter_counts[letter] = letter_groups[letter].size }
  letters_and_counts = letter_counts.keys.map { |key| {key, letter_counts[key]} }

  sorted_letters = letters_and_counts.sort { |a, b| {b.last, a.first} <=> {a.last, b.first} }
  our_checksum = sorted_letters.map(&.first).join("")[0..4]
  our_checksum == checksum
end

def decrypt(line)
  parts = line.strip.split("[")
  checksum = parts.last[0..-2]
  first_parts = parts.first.split("-")
  mod = first_parts.last.to_i % 26
  words = first_parts[0..-2].map do |part|
    word = [] of Char
    (0...part.size).to_a.each do |i|
      word << 'a' + ((part[i].ord - 97) + mod) % 26
    end
    word.join("")
  end

  words.join(" ")
end

#puts sector_id("aaaaa-bbb-z-y-x-123[abxyz]")
#puts sector_id("a-b-c-d-e-f-g-h-987[abcde]")
#puts sector_id("not-a-real-room-404[oarel]")
#puts sector_id("totally-real-room-200[decoy]")
#puts sector_id("szfyrqriuflj-avccpsvre-kirzezex-971[rezcf]")
#puts decrypt("qzmt-zixmtkozy-ivhz-343")

lines.select { |line| valid?(line) }.each do |line|
  if decrypt(line) =~ /north/
    puts line
    puts decrypt(line)
  end
end
