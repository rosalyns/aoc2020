example_input = File.readlines('input/example.txt', chomp: true)
# example_input = File.readlines('day17/input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)
ACTIVE = 1

def go(input)
  @map = {}
  z = 0
  w = 0

  input.each_with_index do |line, y|
    line.each_char.with_index do |char, x|
      next if char != '#'
      add_to_map(@map, x, y, z, w)
    end
  end
end

def add_to_map(map, x, y, z, w)
  if map.key?(x)
    ymap = map[x]
  else
    ymap = {}
    map[x] = ymap
  end

  if ymap.key?(y)
    zmap = ymap[y]
  else
    zmap = {}
    ymap[y] = zmap
  end

  if zmap.key?(z)
    zmap[z] << w
  else
    zmap[z] = [w]
  end
end

def next_generation
  next_map = {}

  @x_range = (@map.keys.min - 1)..(@map.keys.max + 1)
  @y_range = (@map.values.map(&:keys).flatten.min - 1)..(@map.values.map(&:keys).flatten.max + 1)
  @z_range = (@map.values.map(&:values).flatten.map(&:keys).flatten.min - 1)..(@map.values.map(&:values).flatten.map(&:keys).flatten.max + 1)
  @w_range = (@map.values.map(&:values).flatten.map(&:values).flatten.min - 1)..(@map.values.map(&:values).flatten.map(&:values).flatten.max + 1)

  @x_range.to_a.each do |x|
    @y_range.to_a.each do |y|
      @z_range.to_a.each do |z|
        @w_range.to_a.each do |w|
          place = place_at(w, x, y, z)
          neighbours = neighbours(x, y, z, w)
          if place == ACTIVE && [2, 3].include?(neighbours)
            add_to_map(next_map, x, y, z, w)
          elsif place != ACTIVE && neighbours == 3
            add_to_map(next_map, x, y, z, w)
          end
        end
      end
    end
  end

  @map = next_map
end

def neighbours(x, y, z, w)
  result = []
  [-1, 0, 1].repeated_permutation(4).each do |perm|
    next if perm.all?(0)
    result << place_at(w + perm[0], x + perm[1], y + perm[2], z + perm[3])
  end
  result.compact.count
end

def place_at(w, x, y, z)
  warr = @map.dig(x, y, z)
  if warr&.include?(w)
    ACTIVE
  end
end

go(input)

6.times do
  next_generation

  count = 0
  @map.each do |x|
    x[1].each do |y|
      y[1].each do |z|
        count += z[1].count
      end
    end
  end
  puts "count #{count}"
end
