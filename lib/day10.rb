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
  list.reduce([]) do |result, element|
    if result.empty? || result.last.first != element
      result << [element]
    else
      result.last << element
    end

    result
  end
end
