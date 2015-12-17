def find_container_combinations(containers, storage, running_sum = 0)
  if containers.empty?
    running_sum == storage ? 1 : 0
  elsif running_sum > storage
    0
  elsif running_sum == storage
    1
  else
    find_container_combinations(containers[1..-1], storage, running_sum + containers.first) +
      find_container_combinations(containers[1..-1], storage, running_sum)
  end
end

def find_min_container_combinations(containers, storage)
  (1..containers.size).each do |i|
    count = 0
    containers.combination(i).each do |combo|
      if combo.reduce(&:+) == storage
        count += 1
      end
    end

    return count if count > 0
  end

  return 0
end
