example_input = File.readlines('input/example2.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

def algorithm(input, find_bag)
  map = {}
  input.each do |line|
    captures = line.match(/^(.*) contain (.*)\.$/).captures
    outside_bag = captures[0].match(/^(.*) bags$/).captures[0]
    inside_bags = captures[1].split(', ')

    inside_bags.each do |bag|
      captures = bag.match(/^(\d+|no) (.*) bags?$/).captures
      next if captures[0] == 'no'

      if map[outside_bag]
        map[outside_bag] << { amount: captures[0], color: captures[1] }
      else
        map[outside_bag] = [{ amount: captures[0], color: captures[1] }]
      end
    end
  end
  puts map

  puts "output: #{count_bags(map, find_bag) - 1}"
end

def count_bags(map, find_bag)
  sum = 1
  map[find_bag]&.each do |inside_bag|
    sum += inside_bag[:amount].to_i * count_bags(map, inside_bag[:color])
  end

  sum
end
