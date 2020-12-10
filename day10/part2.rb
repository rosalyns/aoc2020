example_input = File.readlines('day10/input/example.txt', chomp: true).map(&:to_i)
example_input2 = File.readlines('day10/input/example2.txt', chomp: true).map(&:to_i)
input = File.readlines('day10/input/input.txt', chomp: true).map(&:to_i)

def algorithm(input)
  input << 0
  input.sort!
  count = 0
  diff = input.each_cons(2).map { |a, b| b - a }
  diff.each_cons(2).each { |a, b| count += 1 if a == b && a == 1 }
  puts "diff #{diff}"
  puts "possible arrangements: #{find_arrangements(diff)}"
end

def find_arrangements(diffs)
  arrs = diffs.join('').split('3')
  options = []
  arrs.each do |arr|
    if arr.length == 1
      next
    elsif arr.length == 2
      options << 2
    elsif arr.length == 3
      options << 4
    elsif arr.length == 4
      options << 7
    end
  end
  options.map(&:to_i).inject(:*)
end
