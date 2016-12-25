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
    ["0", "0", "5", "0", "0"],
    ["0", "2", "6", "A", "0"],
    ["1", "3", "7", "B", "D"],
    ["0", "4", "8", "C", "0"],
    ["0", "0", "9", "0", "0"],
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
    {@x, @y, KEYPAD[@x][@y]}
  end

  def next_index(letter)
    x = @x
    y = @y
    if letter == "U" && @y > 0
      y -= 1
    elsif letter == "D" && @y < 4
      y += 1
    elsif letter == "L" && @x > 0
      x -= 1
    elsif letter == "R" && @x < 4
      x += 1
    end

    unless KEYPAD[x][y] == "0"
      @x = x
      @y = y
    end
  end
end

x = 0
y = 2

puts direction_list.map { |directions|
  result = NumberFinder.new(x, y, directions).perform
  x = result[0]
  y = result[1]
  result[2]
}.join("")
