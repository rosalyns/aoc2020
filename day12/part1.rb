example_input = File.readlines('day12/input/example.txt', chomp: true)
input = File.readlines('day12/input/input.txt', chomp: true)
DIRS = { 0 => 'N', 90 => 'E', 180 => 'S', 270 => 'W' }.freeze
DEGREES = [0, 90, 180, 270].freeze

def algorithm(input)
  @direction_index = 1
  @position = [0, 0]

  input.each do |line|
    letter, number = line.match(/([NSEWLRF])(\d+)/).captures
    process_instruction(letter, number)
  end

  puts "position: #{@position[0]}, #{@position[1]} sum: #{@position[0].abs + @position[1].abs}"
end

def process_instruction(letter, number)
  number = number.to_i
  if letter == 'N'
    @position[1] += number
  elsif letter == 'S'
    @position[1] -= number
  elsif letter == 'E'
    @position[0] += number
  elsif letter == 'W'
    @position[0] -= number
  elsif letter == 'L'
    @direction_index -= (number / 90)
  elsif letter == 'R'
    @direction_index += (number / 90)
  elsif letter == 'F'
    process_instruction(DIRS[DEGREES[@direction_index % 4]], number)
  end
end
