def find_optimal_passenger_seat_packages(packages, compartment_count = 3)
  packages = packages.map(&:to_i)

  package_sum = packages.reduce(&:+)
  raise "not possible" if package_sum % compartment_count != 0

  target_sum = packages.reduce(&:+) / compartment_count

  passenger_seat_possibilities = []
  (1..packages.size / compartment_count).each do |i|
    passenger_seat_possibilities = packages.combination(i).select { |subset| subset.reduce(&:+) == target_sum }
    break unless passenger_seat_possibilities.empty?
  end

  passenger_seat_possibilities.reduce(2 ** 1000) do |current_min, packages|
    current_min = packages.reduce(&:*) < current_min ? packages.reduce(&:*) : current_min
  end
end
