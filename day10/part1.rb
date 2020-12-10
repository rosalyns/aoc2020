example_input = File.readlines('day10/input/example.txt', chomp: true).map(&:to_i)
example_input2 = File.readlines('day10/input/example2.txt', chomp: true).map(&:to_i)
input = File.readlines('day10/input/input.txt', chomp: true).map(&:to_i)

def algorithm(input)
  input << 0
  input.sort!
  diff = input.each_cons(2).map { |a, b| b - a }
  ones = diff.count(1)
  threes = diff.count(3) + 1
  puts "ones: #{ones}"
  puts "threes: #{threes}"
  puts (ones * threes).to_s
end
