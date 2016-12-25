lines = File.read_lines("data/2.txt")

direction_list = lines
#direction_list = [
#  "ULL",
#  "RRDDD",
#  "LURDL",
#  "UUUUD",
#]

class NumberFinder
  KEYPAD = [
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9]
  ]

  @x = 1
  @y = 1
  @directions = [""]

  def initialize(x, y, direction_string)
    @x = x
    @y = y
    @directions = direction_string.split("")
  end

  def perform
    @directions.each { |direction| next_index(direction) }
    [@x, @y, KEYPAD[@x][@y]]
  end

  def next_index(letter)
    if letter == "U" && @y > 0
      @y -= 1
    elsif letter == "D" && @y < 2
      @y += 1
    elsif letter == "L" && @x > 0
      @x -= 1
    elsif letter == "R" && @x < 2
      @x += 1
    end
  end
end

x = y = 1

puts direction_list.map { |directions|
  result = NumberFinder.new(x, y, directions).perform
  x = result[0]
  y = result[1]
  result[2]
}.join("")
