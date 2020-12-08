example_input = File.readlines('day8/input/example.txt', chomp: true)
input = File.readlines('day8/input/input.txt', chomp: true)

def algorithm(input)

  input.each_with_index do |line, i|
    copy = input.dup
    if line.start_with? 'nop'
      copy[i] = line.gsub('nop', 'jmp')
      try_code(copy)
    elsif line.start_with? 'jmp'
      copy[i] = line.gsub('jmp', 'nop')
      try_code(copy)
    end
  end

end

def try_code(input)
  @acc = 0
  @run = Array.new(input.length, 0)

  next_index = 0
  loop_detected = false
  end_reached = false

  until loop_detected || end_reached
    if (@run[next_index]) == 1
      # puts "loop detected, acc is #{@acc}"
      loop_detected = true
    end

    next_index = run_instruction(input, next_index)
    if next_index >= input.length
      puts "end reached, acc is #{@acc}"
      end_reached = true
    end
  end
end

def run_instruction(instructions, index)
  @run[index] += 1
  instr, sign, number = instructions[index].match(/(nop|acc|jmp) ([-+])(\d+)/).captures
  if instr == 'nop'
    index + 1
  elsif instr == 'jmp'
    sign == '+' ? index + number.to_i : index - number.to_i
  elsif instr == 'acc'
    sign == '+' ? @acc += number.to_i : @acc -= number.to_i
    index + 1
  end
end
