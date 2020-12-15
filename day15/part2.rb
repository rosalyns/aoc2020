example_input = File.readlines('day15/input/example.txt', chomp: true).first.split(',')
example_input2 = File.readlines('day15/input/example2.txt', chomp: true).first.split(',')
example_input3 = File.readlines('day15/input/example3.txt', chomp: true).first.split(',')
example_input4 = File.readlines('day15/input/example4.txt', chomp: true).first.split(',')
example_input5 = File.readlines('day15/input/example5.txt', chomp: true).first.split(',')
example_input6 = File.readlines('day15/input/example6.txt', chomp: true).first.split(',')
example_input7 = File.readlines('day15/input/example7.txt', chomp: true).first.split(',')
input = File.readlines('day15/input/input.txt', chomp: true).first.split(',')

def algorithm(input)
  @last_nr = 0
  @map = {}
  @i = 1
  next_nr = 0
  input.each do |line|
    next_nr = process_nr(line.to_i)
  end

  next_nr = process_nr(next_nr) until @i == 30000000

  puts "last nr is #{next_nr}"
end

def process_nr(line)
  if @map.key?(line)
    result = @i - @map[line]
  else
    result = 0
  end
  @map[line] = @i
  @i += 1
  result
end
