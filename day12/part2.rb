example_input = File.readlines('day12/input/example.txt', chomp: true)
input = File.readlines('day12/input/input.txt', chomp: true)
CASES = { 'R90' => 0, 'R180' => 1, 'R270' => 2, 'L90' => 2, 'L180' => 1, 'L270' => 0 }.freeze

def algorithm(input)
  @direction = [10, 1]
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
    @direction[1] += number
  elsif letter == 'S'
    @direction[1] -= number
  elsif letter == 'E'
    @direction[0] += number
  elsif letter == 'W'
    @direction[0] -= number
  elsif 'LR'.include? letter
    case CASES[letter + number.to_s]
    when 0
      @direction[0], @direction[1] = @direction[1], -@direction[0]
    when 1
      @direction[0], @direction[1] = -@direction[0], -@direction[1]
    when 2
      @direction[0], @direction[1] = -@direction[1], @direction[0]
    else
      puts 'ERROR'
  end
  elsif letter == 'F'
    @position[0] += (@direction[0] * number)
    @position[1] += (@direction[1] * number)
  end
end
