def find_container_combinations(containers, storage, running_sum = 0)
  if running_sum == storage
    1
  elsif containers.empty? || running_sum > storage
    0
  else
    find_container_combinations(containers[1..-1], storage, running_sum + containers.first) +
      find_container_combinations(containers[1..-1], storage, running_sum)
  end
end

def find_min_container_combinations(containers, storage)
  (1..containers.size).each do |i|
    count = containers.combination(i).reduce(0) do |running_count, combo|
      combo.reduce(&:+) == storage ? running_count + 1 : running_count
    end

    return count if count > 0
  end

  return 0
end
