example_input = File.readlines('day7/input/example.txt', chomp: true)
input = File.readlines('day7/input/input.txt', chomp: true)

def algorithm(input, find_bag)
  map = {}
  input.each do |line|
    captures = line.match(/^(.*) contain (.*)\.$/).captures
    outside_bag = captures[0].match(/^(.*) bags$/).captures[0]
    inside_bags = captures[1].split(', ').map { |bag| bag.match(/^(\d+|no) (.*) bags?$/).captures[1] }

    inside_bags.each do |bag|
      if map[bag]
        map[bag] << outside_bag
      else
        map[bag] = [outside_bag]
      end
    end
  end
  puts map

  puts "output: #{find_outer_bags(map, find_bag).count}"
end

def find_outer_bags(map, find_bag)
  result = []
  if map[find_bag]
    result += map[find_bag]
    result.each do |nested_bag|
      result += find_outer_bags(map, nested_bag)
    end
  end
  result.uniq
end
