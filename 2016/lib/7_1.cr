ips = File.read_lines("data/7.txt").map(&.strip)

def abba_present?(s)
  (0..s.size - 4).to_a.each do |i|
    return true if s[i] == s[i + 3] &&
                   s[i + 1] == s[i + 2] &&
                   s[i] != s[i + 1]
  end

  false
end

def contains_abba?(s)
  middle_strings = s.split("[")[1..-1].map { |t| t.split("]") }.map(&.first)
  middle_strings.each { |ms| return false if abba_present?(ms) }

  outer_strings = s.split("[").map { |t| t.split("]") }.map(&.last)
  outer_strings.each { |os| return true if abba_present?(os) }

  false
end

#puts contains_abba?("abba[mnop]qrst")
#puts contains_abba?("abcd[bddb]xyyx")
#puts contains_abba?("aaaa[qwer]tyui")
#puts contains_abba?("ioxxoj[asdfgh]zxcvbn")

puts ips.select { |ip| contains_abba?(ip) }.size
