example_input = File.readlines('day11/input/example.txt', chomp: true)
input = File.readlines('day11/input/input.txt', chomp: true)

def algorithm(input)
  @something_changed = true
  while @something_changed
    input = next_generation(input)
  end

  puts "occupied: #{count_all_occupied(input)}"
end

def next_generation(input)
  next_gen = input.map(&:dup)
  @something_changed = false
  input.each_with_index do |line, y|
    line.split('').each_with_index do |place, x|
      next if place == '.'

      if place == 'L' && count_occupied_adjacent(input, x, y) == 0
        next_gen[y][x] = '#'
        @something_changed = true
      elsif place == '#' && count_occupied_adjacent(input, x, y) >= 4
        next_gen[y][x] = 'L'
        @something_changed = true
      end
    end
  end
  next_gen
end

def count_empty_adjacent(input, x, y)
  places_around(input, x, y).count('L')
end

def count_occupied_adjacent(input, x, y)
  places_around(input, x, y).count('#')
end

def places_around(input, x, y)
  width = input.first.length
  height = input.length
  if y.zero? && x.zero?                                                   # top left corner
    [input[y][x + 1],
     input[y + 1][x],
     input[y + 1][x + 1]]
  elsif y.zero? && x == (width - 1)                                       # top right corner
    [input[y][x - 1],
     input[y + 1][x],
     input[y + 1][x - 1]]
  elsif x.zero? && y == (height - 1)                                      # bottom left corner
    [input[y][x - 1],
     input[y - 1][x],
     input[y - 1][x + 1]]
  elsif x == (width - 1) && y == (height - 1)                             # bottom right corner
    [input[y][x - 1],
     input[y - 1][x],
     input[y - 1][x - 1]]
  elsif y.zero?                                                           # top side
    [input[y][x + 1],
     input[y][x - 1],
     input[y + 1][x],
     input[y + 1][x - 1],
     input[y + 1][x + 1]]
  elsif y == (height - 1)                                                 # bottom side
    [input[y][x + 1],
     input[y][x - 1],
     input[y - 1][x],
     input[y - 1][x - 1],
     input[y - 1][x + 1]]
  elsif x.zero?                                                           # left side
    [input[y][x + 1],
     input[y - 1][x],
     input[y + 1][x],
     input[y - 1][x + 1],
     input[y + 1][x + 1]]
  elsif x == (width - 1)                                                  # right side
    [input[y][x - 1],
     input[y - 1][x],
     input[y + 1][x],
     input[y - 1][x - 1],
     input[y + 1][x - 1]]
  else                                                                     # all
    [input[y][x + 1],
     input[y][x - 1],
     input[y - 1][x],
     input[y + 1][x],
     input[y - 1][x - 1],
     input[y - 1][x + 1],
     input[y + 1][x - 1],
     input[y + 1][x + 1]]
  end
end

def count_all_occupied(input)
  input.map { |line| line.count('#') }.sum
end
# input[y - 1][x - 1], input[y - 1][x], input[y - 1][x + 1]
# input[y][x - 1],                      input[y][x + 1]
# input[y + 1][x - 1], input[y + 1][x], input[y + 1][x + 1]
