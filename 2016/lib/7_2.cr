ips = File.read_lines("data/7.txt").map(&.strip)

def collect_abas(s)
  (0..s.size - 3).to_a.map do |i|
    if s[i] == s[i + 2] &&
       s[i] != s[i + 1]
      s[i..i+2]
    else
      nil
    end
  end.compact
end

def aba_to_bab(aba)
  [aba[1], aba[0], aba[1]].join
end

def supports_ssl?(s)
  outer_strings = s.split("[").map { |t| t.split("]") }.map(&.last)
  abas = outer_strings.map { |os| collect_abas(os) }.flatten

  middle_strings = s.split("[")[1..-1].map { |t| t.split("]") }.map(&.first)
  babs = middle_strings.map { |ms| collect_abas(ms) }.flatten

  !(Set.new(abas) & Set.new(babs.map { |aba| aba_to_bab(aba) })).empty?
end

#puts supports_ssl?("aba[bab]xyz")
#puts supports_ssl?("xyx[xyx]xyx")
#puts supports_ssl?("aaa[kek]eke")
#puts supports_ssl?("zazbz[bzb]cdb")

puts ips.select { |ip| supports_ssl?(ip) }.size
