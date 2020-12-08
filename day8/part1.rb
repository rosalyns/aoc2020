example_input = File.readlines('day8/input/example.txt', chomp: true)
input = File.readlines('day8/input/input.txt', chomp: true)

def algorithm(input)
  @acc = 0
  @run = Array.new(input.length, 0)

  next_index = 0
  loop_detected = false

  until loop_detected
    if (@run[next_index]) == 1
      puts "loop detected, acc is #{@acc}"
      loop_detected = true
    end

    next_index = run_instruction(input, next_index)
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
