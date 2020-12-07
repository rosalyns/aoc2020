example_input = File.readlines('input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

def algorithm(map, slopes)
  x = []
  slopes.each do |slope|
    x << trees_with_slope(map, slope[0], slope[1])
  end

  puts "trees: #{x}"
  puts "multiplied: #{x.inject(:*)}"
end

def trees_with_slope(map, right, down)
  current_pos = 0
  trees = 0

  (0..map.length + down).step(down) do |i|
    puts "hi #{i}"
    return trees if i >= map.length

    trees += 1 if tree(map, i, current_pos)
    current_pos += right
  end
end

def tree(map, row, position)
  map[row][(position % map.sample.length)] == '#'
end
