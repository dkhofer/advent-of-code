def get_max_reindeer_distance(lines, time_in_seconds)
  reindeer_speeds = parse_reindeer_speeds(lines)
  reindeer_speeds.map { |speed| distance_after_time(speed, time_in_seconds) }.max
end

def parse_reindeer_speeds(lines)
  lines.map do |line|
    parts = line.split
    {
      name: parts[0],
      speed: parts[3].to_i,
      flying_time: parts[6].to_i,
      rest_time: parts[13].to_i,
      current_location: 0,
      points: 0,
    }
  end
end

def distance_after_time(reindeer, seconds)
  full_flight_rounds = seconds / (reindeer[:flying_time] + reindeer[:rest_time])
  distance = full_flight_rounds * reindeer[:flying_time] * reindeer[:speed]
  partial_flight_round = seconds % (reindeer[:flying_time] + reindeer[:rest_time])
  distance + [partial_flight_round * reindeer[:speed], reindeer[:flying_time] * reindeer[:speed]].min
end

def get_max_reindeer_points(lines, time_in_seconds)
  reindeer_speeds = parse_reindeer_speeds(lines)

  (1..time_in_seconds).each do |i|
    reindeer_speeds.each { |speed| speed[:current_location] = distance_after_time(speed, i) }
    max_location = reindeer_speeds.map { |speed| speed[:current_location] }.max
    reindeer_speeds.each { |speed| speed[:points] += 1 if speed[:current_location] == max_location }
  end

  reindeer_speeds.map { |speed| speed[:points] }.max
end
