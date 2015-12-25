SPELLS = [:shield, :drain, :recharge, :poison, :magic_missile].freeze
MANA_COST = {
  :shield => 113,
  :drain => 73,
  :recharge => 229,
  :poison => 173,
  :magic_missile => 53,
}.freeze

class GameState
  attr_accessor :my_hit_points, :boss_hit_points, :mana, :mana_spent, :remaining_shield_rounds, :remaining_poison_rounds, :remaining_recharge_rounds, :output_lines, :winner

  def initialize(my_stats, boss_stats)
    @my_hit_points = my_stats[:hit_points]
    @boss_hit_points = boss_stats[:hit_points]
    @mana = my_stats[:mana]
    @mana_spent = 0
    @remaining_shield_rounds = 0
    @remaining_poison_rounds = 0
    @remaining_recharge_rounds = 0
    @output_lines = []
    @winner = nil
  end

  def copy_instance(my_stats, boss_stats)
    new_game_state = GameState.new(my_stats, boss_stats)
    new_game_state.my_hit_points = @my_hit_points
    new_game_state.boss_hit_points = @boss_hit_points
    new_game_state.mana = @mana
    new_game_state.mana_spent = @mana_spent
    new_game_state.remaining_shield_rounds = @remaining_shield_rounds
    new_game_state.remaining_poison_rounds = @remaining_poison_rounds
    new_game_state.remaining_recharge_rounds = @remaining_recharge_rounds
    new_game_state.output_lines = @output_lines.clone
    new_game_state.winner = @winner

    return new_game_state
  end

  def add_lines(lines)
    @output_lines.concat(lines)
  end

  def add_line(line)
    @output_lines << line
  end

  def update_effects(boss_damage, hard_mode = false, turn = :me)
    if @remaining_recharge_rounds > 0
      @mana += 101
      @remaining_recharge_rounds -= 1
      add_line("Recharge provides 101 mana (to #{@mana}); its timer is now #{@remaining_recharge_rounds}.")
      add_line("Recharge wears off.") if @remaining_recharge_rounds == 0
    end

    if @remaining_shield_rounds > 0
      boss_damage -= 7
      @remaining_shield_rounds -= 1
      add_line("Shield's timer is now #{@remaining_shield_rounds}.")
      add_line("Shield wears off, decreasing armor by 7.") if @remaining_shield_rounds == 0
    end

    if @remaining_poison_rounds > 0
      @boss_hit_points -= 3
      @remaining_poison_rounds -= 1
      add_line("Poison deals 3 damage; its timer is now #{@remaining_poison_rounds}.")
    end

    if hard_mode && turn == :me
      @my_hit_points -= 1
    end

    return boss_damage
  end

  def check_if_done
    if @boss_hit_points <= 0
      @winner = :me
    elsif @my_hit_points <= 0
      @winner = :boss
    end

    return !@winner.nil?
  end

  def can_cast(spell)
    return false if MANA_COST[spell] > @mana

    return false if spell == :shield && @remaining_shield_rounds > 0
    return false if spell == :poison && @remaining_poison_rounds > 0
    return false if spell == :recharge && @remaining_recharge_rounds > 0

    return true
  end

  def cast_spell(spell)
    my_damage = 0
    if spell == :shield
      add_line("Player casts shield spell.")
      @remaining_shield_rounds = 6
      @mana -= 113
      @mana_spent += 113
    elsif spell == :drain
      add_line("Player casts drain spell.")
      @my_hit_points += 2
      my_damage = 2
      @mana -= 73
      @mana_spent += 73
    elsif spell == :recharge
      add_line("Player casts recharge spell.")
      @remaining_recharge_rounds = 5
      @mana -= 229
      @mana_spent += 229
    elsif spell == :poison
      add_line("Player casts poison spell.")
      @remaining_poison_rounds = 6
      @mana -= 173
      @mana_spent += 173
    elsif spell == :magic_missile
      add_line("Player casts magic missile spell.")
      my_damage = 4
      @mana -= 53
      @mana_spent += 53
    end

    return my_damage
  end
end

def magic_fight_result(my_stats, boss_stats, hard_mode = false)
  base_game_state = GameState.new(my_stats, boss_stats)

  boss_damage = boss_stats[:damage]

  game_states = Set.new([base_game_state])

  min_mana_game_state = nil

  turn = :me

  while !game_states.empty?
    new_game_states = Set.new
    game_states.each do |game_state|
      actual_boss_damage = boss_damage

      game_state.add_lines([
                             "----------------------------------------------------------",
                             "Player has #{game_state.my_hit_points} hit points, #{game_state.mana} mana.",
                             "Boss has #{game_state.boss_hit_points} hit points.",
                           ])

      actual_boss_damage = game_state.update_effects(boss_damage, hard_mode, turn)

      if game_state.check_if_done
        if game_state.my_hit_points > 0 && (min_mana_game_state.nil? || min_mana_game_state.mana_spent > game_state.mana_spent)
          min_mana_game_state = game_state
        end
      else
        if (turn == :me)
          SPELLS.each do |spell|
            if game_state.can_cast(spell)
              new_game_state = game_state.copy_instance(my_stats, boss_stats)
              my_damage = new_game_state.cast_spell(spell)
              new_game_state.add_line("Player deals #{my_damage} damage.")
              new_game_state.boss_hit_points -= my_damage

              if new_game_state.check_if_done
                if min_mana_game_state.nil? || min_mana_game_state.mana_spent > new_game_state.mana_spent
                  min_mana_game_state = new_game_state
                end
              else
                new_game_states.add(new_game_state)
              end
            end
          end
        else
          new_game_state = game_state.copy_instance(my_stats, boss_stats)
          new_game_state.add_line("Boss deals #{[actual_boss_damage, 1].max} damage.")
          new_game_state.my_hit_points -= [actual_boss_damage, 1].max

          new_game_states.add(new_game_state) unless new_game_state.check_if_done
        end
      end

    end

    turn = (turn == :me) ? :boss : :me
    game_states = new_game_states
  end

  return min_mana_game_state.mana_spent
end
