def day1(filename)
  parens = File.readlines(filename).first.strip.split("")
  floor, first_basement_position = process_parens(parens)

  puts "Floor: #{floor}"
  puts "First basement paren: #{first_basement_position}"
end

def process_parens(parens)
  counter = 0
  first_basement_position = nil
  parens.each_with_index do |paren, i|
    if paren == "("
      counter += 1
    elsif paren == ")"
      counter -= 1
      if counter == -1
        first_basement_position ||= i + 1
      end
    else
      raise "Unknown character: #{paren}"
    end
  end

  return [counter, first_basement_position]
end
