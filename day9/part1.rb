example_input = File.readlines('day9/input/example.txt', chomp: true)
input = File.readlines('day9/input/input.txt', chomp: true)

def algorithm(input, preamble_size)
  next_pointer = 0
  @rule_error = 0
  @preamble = Array.new(preamble_size)

  while @rule_error == 0
    next_pointer = xmas(input, next_pointer, preamble_size)
  end

  puts "rule error! #{@rule_error}"
end

def xmas(code, pointer, preamble_size)
  if !@preamble.all?
    @preamble[pointer] = code[pointer].to_i
    puts "preamble #{@preamble}"
    pointer + 1
  else
    sum_found = false
    @preamble.combination(2).each do |combi|
      if combi.sum == code[pointer].to_i
        sum_found = true
        @preamble[pointer % preamble_size] = code[pointer].to_i
        break
      end
    end
    puts "sum found? #{sum_found}"
    puts "preamble #{@preamble}"
    if sum_found
      pointer + 1
    else
      @rule_error = code[pointer].to_i
    end
  end
end
