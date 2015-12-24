def magic_fight_result(my_stats, boss_stats)
  my_hit_points = my_stats[:hit_points]
  mana = my_stats[:mana]
  boss_hit_points = boss_stats[:hit_points]
  boss_damage = boss_stats[:damage]

  mana_used = 0

  remaining_shield_rounds = 0
  remaining_poison_rounds = 0
  remaining_recharge_rounds = 0

  turn = :me
  while my_hit_points > 0 && boss_hit_points > 0
    my_damage = 0
    actual_boss_damage = boss_damage

    puts "----------------------------------------------------------"
    puts "Player has #{my_hit_points} hit points, #{mana} mana."
    puts "Boss has #{boss_hit_points} hit points."

    if remaining_recharge_rounds > 0
      mana += 101
      remaining_recharge_rounds -= 1
      puts "Recharge provides 101 mana (to #{mana}); its timer is now #{remaining_recharge_rounds}."
      puts "Recharge wears off." if remaining_recharge_rounds == 0
    end

    if remaining_shield_rounds > 0
      actual_boss_damage -= 7
      remaining_shield_rounds -= 1
      puts "Shield's timer is now #{remaining_shield_rounds}."
      puts "Shield wears off, decreasing armor by 7." if remaining_shield_rounds == 0
    end

    if remaining_poison_rounds > 0
      my_damage += 3
      remaining_poison_rounds -= 1
      puts "Poison deals 3 damage; its timer is now #{remaining_poison_rounds}."
    end

    if (turn == :me)
      spell = choose_spell(mana,
                           my_hit_points,
                           remaining_shield_rounds > 0,
                           remaining_poison_rounds > 0,
                           remaining_recharge_rounds > 0,
                           boss_damage)
      if spell == :shield
        puts "Player casts shield spell."
        remaining_shield_rounds = 6
        mana -= 113
        mana_used += 113
      elsif spell == :drain
        puts "Player casts drain spell."
        my_hit_points += 2
        my_damage += 2
        mana -= 73
        mana_used += 73
      elsif spell == :recharge
        puts "Player casts recharge spell."
        remaining_recharge_rounds = 5
        mana -= 229
        mana_used += 229
      elsif spell == :poison
        puts "Player casts poison spell."
        remaining_poison_rounds = 6
        mana -= 173
        mana_used += 173
      elsif spell == :magic_missile
        puts "Player casts magic missile spell."
        my_damage += 4
        mana -= 53
        mana_used += 53
      end
    end

    if turn == :me || remaining_poison_rounds > 0
      puts "Player deals #{my_damage} damage."
      boss_hit_points -= my_damage
      next_turn = :boss
    end

    if turn == :boss
      puts "Boss deals #{[actual_boss_damage, 1].max} damage."
      my_hit_points -= [actual_boss_damage, 1].max
      next_turn = :me
    end

    turn = next_turn
  end

  if my_hit_points <= 0
    return [:boss, mana]
  else
    return [:me, mana_used]
  end
end

def choose_spell(mana, my_hit_points, shield_in_effect, poison_in_effect, recharge_in_effect, boss_damage)
  if !shield_in_effect
    :shield
  elsif my_hit_points <= boss_damage - 7
    :drain
  elsif !recharge_in_effect && mana < 405
    :recharge
  elsif (!poison_in_effect)
    :poison
  else
    :magic_missile
  end
end
