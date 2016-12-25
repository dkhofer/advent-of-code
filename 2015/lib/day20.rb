def divisors(n)
  result = Set.new([1,n])
  return result if n == 2

  min_divisor = (2..Math.sqrt(n).to_i + 1).find { |i| n % i == 0 }

  if min_divisor
    result.merge(divisors(min_divisor))
    result.merge(divisors(n / min_divisor))

    # NOTE(hofer): 12 = 2 * 6
    # But if we just merge the results of the recursive calls for 2
    # and 6, we won't get 4.
    all_products = result.to_a.product(result.to_a).map { |pair| pair.first * pair.last }
    products = all_products.select { |product| product < n && n % product == 0 }
    result.merge(products)
  end

  return result
end

def house_presents(house_number, return_if_really_big = false, part2 = false)
  counts = (1..house_number).map { 0 }
  max_so_far = 0
  (1..house_number).each do |i|
    if part2
      counts[i-1] = divisors(i).reject { |j| i > 50 * j }.reduce(&:+) * 11
    else
      counts[i-1] = divisors(i).reduce(&:+) * 10
    end

    if return_if_really_big && counts[i-1] >= house_number
      return i
    end

    if counts[i-1] > max_so_far
      max_so_far = counts[i-1]
    end
  end

  return counts.last
end

def house_with_lots_of_presents
  house_presents(33100000, true)
end

def modified_house_with_lots_of_presents
  house_presents(33100000, true, true)
end
