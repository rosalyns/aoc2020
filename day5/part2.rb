example_input = File.readlines('day5/input/example.txt', chomp: true)
input = File.readlines('day5/input/input.txt', chomp: true)

def algorithm(input)
  seat_ids = []

  input.each do |line|
    row = find_number(line[0..6])
    column = find_number(line[7..9])
    seat_ids << seat_id(row, column)
  end
  puts "seat ids: #{seat_ids.sort}"
  puts "missing: #{(53..896).to_a - seat_ids}"
end

def find_number(directions)
  directions.gsub('B', '1').gsub('F', '0').gsub('R', '1').gsub('L', '0').to_i(2)
end

def seat_id(row, column)
  (row * 8) + column
end
