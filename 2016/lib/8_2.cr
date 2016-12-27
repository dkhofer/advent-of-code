lines = File.read_lines("data/8.txt").map(&.strip)

class SecurityScreen
  getter :screen

  @screen = Array(Array(Bool)).new

  def initialize(x, y)
    @screen = x.times.map { y.times.map { false }.to_a }.to_a
  end

  def execute(line)
    if line[0..3] == "rect"
      dimensions = line.split(" ").last.split("x").map(&.to_i)
      rect(dimensions.last, dimensions.first)
    elsif line[0..5] == "rotate"
      parts = line.split(" ")
      index = parts[2].split("=").last.to_i
      amount = parts[4].to_i
      if parts[1] == "row"
        rotate_row(index, amount)
      elsif parts[1] == "column"
        rotate_column(index, amount)
      else
        raise("Unknown way to rotate")
      end
    else
      raise("Unknown command")
    end
  end

  def rect(x, y)
    (0...x).each { |i| (0...y).each { |j| @screen[i][j] = !@screen[i][j] } }
  end

  def rotate_row(x, r)
    @screen[x].rotate!(-r)
  end

  def rotate_column(y, r)
    column = (0...@screen.size).map { |i| @screen[i][y] }
    column.rotate!(-r)
    (0...@screen.size).map { |i| @screen[i][y] = column[i] }
  end

  def to_s
    @screen.map do |row|
      row.map do |element|
        element ? "#" : "."
      end.join(" ")
    end.join("\n")
  end

  def lit_size
    @screen.map { |row| row.select { |element| element }.size }.sum
  end
end

ss = SecurityScreen.new(3, 7)
# ss.rect(2, 3)
# puts ss.to_s
# puts "---"
# ss.rotate_column(1, 1)
# puts ss.to_s
# puts "---"
# ss.rotate_row(0, 4)
# puts ss.to_s
# puts "---"
# ss.rotate_column(1, 1)
# puts ss.to_s

# puts "---"
# ss.execute("rect 3x2")
# puts ss.lit_size
# puts "---"
# ss.execute("rotate column x=1 by 1")
# puts ss.to_s
# puts "---"
# ss.execute("rotate row y=0 by 4")
# puts ss.to_s
# puts "---"
# ss.execute("rotate column x=1 by 1")
# puts ss.to_s

ss = SecurityScreen.new(6, 50)
lines.each { |line| ss.execute(line) }
puts ss.to_s
