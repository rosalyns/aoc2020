example_input = File.readlines('input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

def algorithm(input)
  max = 0
  input.each do |line|
    row = find_number(line[0..6])
    column = find_number(line[7..9])
    seat_id = seat_id(row, column)
    if seat_id > max
      max = seat_id
    end
    puts "row: #{row}, column: #{column}, seat id: #{seat_id}"
  end
  puts "highest: #{max}"
end

def find_number(directions)
  directions.gsub('B', '1').gsub('F', '0').gsub('R', '1').gsub('L', '0').to_i(2)
end

def seat_id(row, column)
  (row * 8) + column
end
