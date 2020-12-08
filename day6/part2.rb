example_input = File.readlines('day6/input/example.txt', chomp: true)
input = File.readlines('day6/input/input.txt', chomp: true)

def algorithm(input)
  sum = 0
  letters = ('a'..'z').to_a
  input.each do |line|
    if line.empty?
      sum += letters.uniq.count
      letters = ('a'..'z').to_a
      next
    end

    letters &= line.scan /\w/
  end
  sum += letters.uniq.count

  puts "sum #{sum}"
end


