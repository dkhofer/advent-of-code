def run_program(lines, a_value = 0)
  a = a_value
  b = 0
  i = 0
  while i >= 0 && i < lines.length
    parts = lines[i].split
    instruction = parts[0]
    if instruction == "hlf"
      if parts[1] == "a"
        a /= 2
      elsif parts[1] == "b"
        b /= 2
      else
        raise "Unknown register.  Line: #{lines[i]}"
      end

      i += 1
    elsif instruction == "tpl"
      if parts[1] == "a"
        a *= 3
      elsif parts[1] == "b"
        b *= 3
      else
        raise "Unknown register.  Line: #{lines[i]}"
      end

      i += 1
    elsif instruction == "inc"
      if parts[1] == "a"
        a += 1
      elsif parts[1] == "b"
        b += 1
      else
        raise "Unknown register.  Line: #{lines[i]}"
      end

      i += 1
    elsif instruction == "jmp"
      amount = parts[1]
      if amount[0] == "+"
        i += amount[1..-1].to_i
      else
        i -= amount[1..-1].to_i
      end
    elsif instruction == "jie"
      if parts[1] == "a,"
        register = a
      else
        register = b
      end
      if register % 2 == 0
        amount = parts[2]
        if amount[0] == "+"
          i += amount[1..-1].to_i
        else
          i -= amount[1..-1].to_i
        end
      else
        i += 1
      end
    elsif instruction == "jio"
      if parts[1] == "a,"
        register = a
      else
        register = b
      end
      if register == 1
        amount = parts[2]
        if amount[0] == "+"
          i += amount[1..-1].to_i
        else
          i -= amount[1..-1].to_i
        end
      else
        i += 1
      end
    else
      raise "Unknown instruction. Line: #{lines[i]}"
    end
  end

  return [a, b]
end
