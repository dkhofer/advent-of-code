require 'json'

def sum_json_numbers(json, ignore_red = false)
  parsed_json = JSON.parse(json)
  recursive_sum_numbers(parsed_json, ignore_red)
end

def recursive_sum_numbers(input, ignore_red = false)
  case input
  when Array
    input.reduce(0) { |sum, element| sum + recursive_sum_numbers(element, ignore_red) }
  when Hash
    if ignore_red && input.values.include?("red")
      0
    else
      sum = input.keys.reduce(0) { |sum, element| sum + recursive_sum_numbers(element, ignore_red) }
      sum + input.values.reduce(0) { |sum, element| sum + recursive_sum_numbers(element, ignore_red) }
    end
  when Numeric
    input
  when String
    0
  else
    raise "Unknown input type.  Input: #{input} Type: #{input.class}"
  end
end
