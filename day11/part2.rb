example_input = File.readlines('day11/input/example.txt', chomp: true)
all_seats = File.readlines('day11/input/all_seats.txt', chomp: true)
no_seats = File.readlines('day11/input/no_seats.txt', chomp: true)
one_seat = File.readlines('day11/input/one_seat.txt', chomp: true)
input = File.readlines('day11/input/input.txt', chomp: true)

def algorithm(input)
  @width = input.first.length
  @height = input.length
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
      elsif place == '#' && count_occupied_adjacent(input, x, y) >= 5
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
  if y.zero? && x.zero?                                                   # top left corner
    places = [find_dir(input,x,y,:right),
     find_dir(input,x,y,:down),
     find_dir(input,x,y,:down_right)]
  elsif y.zero? && x == (@width - 1)                                       # top right corner
    places = [find_dir(input,x,y,:left),
     find_dir(input,x,y,:down),
     find_dir(input,x,y,:down_left)]
  elsif x.zero? && y == (@height - 1)                                      # bottom left corner
    places = [find_dir(input,x,y,:right),
     find_dir(input,x,y,:up),
     find_dir(input,x,y,:up_right)]
  elsif x == (@width - 1) && y == (@height - 1)                             # bottom right corner
    places = [find_dir(input,x,y,:left),
     find_dir(input,x,y,:up),
     find_dir(input,x,y,:up_left)]
  elsif y.zero?                                                           # top side
    places = [find_dir(input,x,y,:left),
     find_dir(input,x,y,:down),
     find_dir(input,x,y,:right),
     find_dir(input,x,y,:down_left),
     find_dir(input,x,y,:down_right)]
  elsif y == (@height - 1)                                                 # bottom side
    places = [find_dir(input,x,y,:left),
     find_dir(input,x,y,:up),
     find_dir(input,x,y,:right),
     find_dir(input,x,y,:up_left),
     find_dir(input,x,y,:up_right)]
  elsif x.zero?                                                           # left side
    places = [find_dir(input,x,y,:up),
     find_dir(input,x,y,:down),
     find_dir(input,x,y,:right),
     find_dir(input,x,y,:up_right),
     find_dir(input,x,y,:down_right)]
  elsif x == (@width - 1)                                                  # right side
    places = [find_dir(input,x,y,:left),
     find_dir(input,x,y,:down),
     find_dir(input,x,y,:up),
     find_dir(input,x,y,:down_left),
     find_dir(input,x,y,:up_left)]
  else                                                                     # all
    places = [find_dir(input,x,y,:left),
     find_dir(input,x,y,:down),
     find_dir(input,x,y,:right),
     find_dir(input,x,y,:up),
     find_dir(input,x,y,:down_left),
     find_dir(input,x,y,:up_left),
     find_dir(input,x,y,:down_right),
     find_dir(input,x,y,:up_right)]
  end
  places.compact
end

def find_dir(input, xco, yco, dir)
  x = xco.dup
  y = yco.dup
  if dir == :up_left
    x -= 1
    y -= 1
    until y < 0 || x < 0
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      x -= 1
      y -= 1
    end
  elsif dir == :up
    y -= 1
    until y < 0
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      y -= 1
    end
  elsif dir == :up_right
    x += 1
    y -= 1
    until y < 0 || x >= @width
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      x += 1
      y -= 1
    end
  elsif dir == :left
    x -= 1
    until x < 0
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      x -= 1
    end
  elsif dir == :right
    x += 1
    until x >= @width
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      x += 1
    end
  elsif dir == :down_left
    x -= 1
    y += 1
    until x < 0 || y >= @height
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      x -= 1
      y += 1
    end
  elsif dir == :down
    y += 1
    until y >= @height
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      y += 1
    end
  elsif dir == :down_right
    x += 1
    y += 1
    until y >= @height || x >= @width
      return input[y][x] if input[y][x] == 'L' || input[y][x] == '#'
      x += 1
      y += 1
    end
  end
  nil
end

def count_all_occupied(input)
  input.map { |line| line.count('#') }.sum
end
