def fight_result(my_stats, boss_stats)
  my_damage = my_stats[1] - boss_stats[2]
  boss_damage = boss_stats[1] - my_stats[2]
  my_hit_points = my_stats[0]
  boss_hit_points = boss_stats[0]

  turn = :me
  while my_hit_points > 0 && boss_hit_points > 0
    if turn == :me
      boss_hit_points -= my_damage
      turn = :boss
    else
      my_hit_points -= boss_damage
      turn = :me
    end
  end

  if my_hit_points <= 0
    return :boss
  else
    return :me
  end
end
