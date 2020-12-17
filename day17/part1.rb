example_input = File.readlines('input/example.txt', chomp: true)
# example_input = File.readlines('day17/input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

@map = []
@x_range = -1..9
@y_range = -1..9
@z_range = -1..1

input.each_with_index do |line, y|
  line.each_char.with_index do |char, x|
    @map << { x: x, y: y, z: 0 } if char == '#'
  end
end

def next_generation
  result_array = []

  @x_range.to_a.each do |x|
    @y_range.to_a.each do |y|
      @z_range.to_a.each do |z|
        place = place_at(x, y, z)
        if place == '#' && (count_occupied_adjacent(x, y, z) == 2 || count_occupied_adjacent(x, y, z) == 3)
          result_array << { x: x, y: y, z: z }
        elsif place == '.' && count_occupied_adjacent(x, y, z) == 3
          result_array << { x: x, y: y, z: z }
        end

        puts "ERROR" unless count_empty_adjacent(x,y,z) + count_occupied_adjacent(x,y,z) == 26
      end
    end
  end

  @map = result_array.uniq

  @x_range = (@map.map { |set| set[:x] }.min - 1)..(@map.map { |set| set[:x] }.max + 1)
  @y_range = (@map.map { |set| set[:y] }.min - 1)..(@map.map { |set| set[:y] }.max + 1)
  @z_range = (@map.map { |set| set[:z] }.min - 1)..(@map.map { |set| set[:z] }.max + 1)
end

def count_occupied_adjacent(x, y, z)
  places_around(x, y, z).count('#')
end

def count_empty_adjacent(x, y, z)
  places_around(x, y, z).count('.')
end

def places_around(x, y, z)
  [place_at(x - 1, y - 1, z - 1),
   place_at(x - 1, y - 1, z),
   place_at(x - 1, y - 1, z + 1),
   place_at(x - 1, y, z - 1),
   place_at(x - 1, y, z),
   place_at(x - 1, y, z + 1),
   place_at(x - 1, y + 1, z - 1),
   place_at(x - 1, y + 1, z),
   place_at(x - 1, y + 1, z + 1),
   place_at(x, y - 1, z - 1),
   place_at(x, y - 1, z),
   place_at(x, y - 1, z + 1),
   place_at(x, y, z - 1),
   # place_at(x, y, z), middle
   place_at(x, y, z + 1),
   place_at(x, y + 1, z - 1),
   place_at(x, y + 1, z),
   place_at(x, y + 1, z + 1),
   place_at(x + 1, y - 1, z - 1),
   place_at(x + 1, y - 1, z),
   place_at(x + 1, y - 1, z + 1),
   place_at(x + 1, y, z - 1),
   place_at(x + 1, y, z),
   place_at(x + 1, y, z + 1),
   place_at(x + 1, y + 1, z - 1),
   place_at(x + 1, y + 1, z),
   place_at(x + 1, y + 1, z + 1)]
end

def place_at(x, y, z)
  if @map.any? { |set| set.values == [x, y, z] }
    '#'
  else
    '.'
  end
end

6.times do
  next_generation
  puts "map size #{@map.size}"
end
