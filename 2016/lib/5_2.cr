require "crypto/md5"

def character_from_index(i : Int64, door_id : String, password : Array(String))
  hash = Crypto::MD5.hex_digest(door_id + i.to_s)
  if hash =~ /^00000/ &&
     (0..7).to_a.map(&.to_s).includes?(hash[5].to_s) &&
     password[hash[5].to_i] == "_"
    password[hash[5].to_i] = hash[6].to_s
    true
  else
    false
  end
end

def find_next_character(i : Int64, door_id : String, password : Array(String))
  until character_from_index(i, door_id, password)
    i += 1
  end
  puts password.join("")
end

#door_id = "abc"
door_id = "wtnhxymk"

index = 0_i64
password = ("_" * 8).split("")

while password.includes?("_")
  find_next_character(index, door_id, password)
end

puts password.join
