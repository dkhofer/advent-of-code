def look_and_say(input)
  result = input
  40.times do
    result = iterate_numbers(result)
  end

  puts "Result length after 40 iterations: #{result.length}"

  10.times do
    result = iterate_numbers(result)
  end

  puts "Result length after 50 iterations: #{result.length}"
end

def iterate_numbers(current_string)
  numbers = current_string.split("")
  grouped_elements = group_adjacent_elements(numbers)
  grouped_elements.map { |list| [list.count, list.first] }.flatten.join
end

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
