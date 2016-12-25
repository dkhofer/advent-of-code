def day1(filename)
  parens = File.readlines(filename).first.strip.split("")
  floor, first_basement_position = process_parens(parens)

  puts "Floor: #{floor}"
  puts "First basement paren: #{first_basement_position}"
end

def process_parens(parens)
  (0...parens.length).reduce([0, nil]) do |parts, i|
    counter = parts.first + (parens[i] == "(" ? 1 : -1)
    first_basement_position = parts.last || (counter == -1 ? i + 1 : nil)
    [counter, first_basement_position]
  end
end
