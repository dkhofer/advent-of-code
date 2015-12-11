def next_password(input)
  next_password = increment_password(input)
  while !password_valid?(next_password)
    next_password = increment_password(next_password)
  end

  next_password
end

def to_base_26(s)
  s.tr("abcdefghijklmnopqrstuvwxyz", "0123456789abcdefghijklmnop").to_i(26)
end

def from_base_26(n)
  n.to_s(26).tr("0123456789abcdefghijklmnop", "abcdefghijklmnopqrstuvwxyz")
end

def increment_password(p)
  next_p = from_base_26(to_base_26(p) + 1)
  while next_p.length < 8
    next_p = "a" + next_p
  end
  next_p
end

def password_valid?(p)
  n = p.split("").map(&method(:to_base_26))
  return false unless (0..5).reduce(false) { |result, i| result || ((n[i] + 1 == n[i+1]) && (n[i+1] + 1 == n[i+2])) }

  return false unless (p =~ /[iol]/).nil?

  grouped_numbers = group_adjacent_elements(n)
  lists = grouped_numbers.select { |list| list.count > 1 }
  return false unless lists.size > 1

  return lists[0].first != lists[1].first
end

# NOTE(hofer): Thanks, day 10!
def group_adjacent_elements(list)
  result = []
  current = []
  list.each do |element|
    if current.empty? || current.first == element
      current << element
    else
      result << current
      current = [element]
    end
  end

  result << current
  result
end
