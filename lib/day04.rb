require 'digest'

def lowest_zero_prefix_number(key, n)
  i = 1
  current_hash_input = "#{key}1"
  while !Digest::MD5.hexdigest(current_hash_input).start_with?("0" * n)
    i += 1
    current_hash_input = "#{key}#{i}"
  end

  current_hash_input.split(key).last.to_i
end
