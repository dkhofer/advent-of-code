class BotState
  getter :bot_contents
  getter :bot_instructions
  getter :output_contents

  def parse_value_instruction(instruction)
    parts = instruction.split(" ")
    value = parts[1].to_i
    bot_id = parts[5].to_i

    @bot_contents[bot_id] ||= [] of Int32
    @bot_contents[bot_id] << value

    raise("Bot contains too many chips!") unless @bot_contents[bot_id].size <= 2
  end

  def parse_bot_instruction(instruction)
    parts = instruction.split(" ")
    bot_id = parts[1].to_i

    if parts[5] == "bot"
      low = "b"
    else
      low = "o"
    end
    low += parts[6]

    if parts[10] == "bot"
      high = "b"
    else
      high = "o"
    end
    high += parts.last

    @bot_instructions[bot_id] ||= [] of String
    @bot_instructions[bot_id] = [low, high]
  end

  def initialize(instructions)
    @bot_contents = Hash(Int32, Array(Int32)).new
    @bot_instructions = Hash(Int32, Array(String)).new
    @output_contents = Hash(Int32, Int32).new

    instructions.each do |instruction|
      if instruction[0..4] == "value"
        parse_value_instruction(instruction)
      elsif instruction[0..2] == "bot"
        parse_bot_instruction(instruction)
      else
        raise "Unknown instruction"
      end
    end
  end

  def update_contents
    @bot_contents.keys.each do |bot_id|
      contents = @bot_contents[bot_id]

      if contents.size == 2
        low, high = @bot_instructions[bot_id]

        low_id = low[1..-1].to_i
        if low[0] == 'o'
          @output_contents[low_id] = contents.sort.first
        else
          @bot_contents[low_id] ||= [] of Int32
          @bot_contents[low_id] << contents.sort.first
        end

        high_id = high[1..-1].to_i
        if high[0] == 'o'
          @output_contents[high_id] = contents.sort.last
        else
          @bot_contents[high_id] ||= [] of Int32
          @bot_contents[high_id] << contents.sort.last
        end

        @bot_contents[bot_id] = [] of Int32
      end
    end
  end

  def done?
    !Set.new(@bot_contents.values.map(&.size)).includes?(2)
  end

  def perform
    until done?
      update_contents
    end
  end
end

# lines = [
#  "value 5 goes to bot 2",
#  "bot 2 gives low to bot 1 and high to bot 0",
#  "value 3 goes to bot 1",
#  "bot 1 gives low to output 1 and high to bot 0",
#  "bot 0 gives low to output 2 and high to output 0",
#  "value 2 goes to bot 2",
# ]

lines = File.read_lines("data/10.txt").map(&.strip)

state = BotState.new(lines)
state.perform

c = state.output_contents
puts c[0] * c[1] * c[2]
