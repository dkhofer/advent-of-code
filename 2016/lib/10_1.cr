class BotState
  getter :bot_contents
  getter :bot_instructions
  getter :bot_records

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
    low = parts[6].to_i
    high = parts.last.to_i

    @bot_instructions[bot_id] ||= [] of Int32
    @bot_instructions[bot_id] = [low, high]
  end

  def initialize(instructions)
    @bot_contents = Hash(Int32, Array(Int32)).new
    @bot_instructions = Hash(Int32, Array(Int32)).new
    @bot_records = Hash(Int32, Array(Array(Int32))).new

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
        @bot_records[bot_id] ||= [] of Array(Int32)
        low, high = @bot_instructions[bot_id]
        @bot_records[bot_id] << contents

        @bot_contents[low] ||= [] of Int32
        @bot_contents[high] ||= [] of Int32
        @bot_contents[low] << contents.sort.first
        @bot_contents[high] << contents.sort.last

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

#lines = [
#  "value 5 goes to bot 2",
#  "bot 2 gives low to bot 1 and high to bot 0",
#  "value 3 goes to bot 1",
#  "bot 1 gives low to output 1 and high to bot 0",
#  "bot 0 gives low to output 2 and high to output 0",
#  "value 2 goes to bot 2",
#]

lines = File.read_lines("data/10.txt").map(&.strip)

state = BotState.new(lines)
state.perform

state.bot_records.keys.each do |bot_id|
  if state.bot_records[bot_id].includes?([61, 17])
    puts bot_id
  end
end

