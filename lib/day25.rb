def find_weather_code(i, j)
  code = 20151125

  raise "i and j are too low" unless i + j > 2

  (3..i+j).each do |k|
    parts = number_partitions(k)

    if k == i + j
      parts.each do |part|
        if part[0] == i && part[1] == j
          return increment_code(code)
        else
          code = increment_code(code)
        end
      end
    else
      parts.each { |part| code = increment_code(code) }
    end
  end

  raise "Shouldn't get here!"
end

def increment_code(code)
  (code * 252533) % 33554393
end

def number_partitions(n)
  (1..n-1).map { |i| [n - i, i] }
end
