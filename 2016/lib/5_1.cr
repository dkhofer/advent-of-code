require "crypto/md5"

def character_from_index(i : Int64, door_id : String)
  hash = Crypto::MD5.hex_digest(door_id + i.to_s)
  if hash =~ /^00000/
    hash[5]
  else
    nil
  end
end

def find_next_character(i : Int64, door_id : String)
  char = nil
  while char.nil?
    char = character_from_index(i, door_id)
    i += 1
  end

  {i, char}
end

#door_id = "abc"
door_id = "wtnhxymk"

index = 0_i64

chars = 8.times.map do
  result = find_next_character(index, door_id)
  index = result.first
  result.last
end

puts chars.join("")
