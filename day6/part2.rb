example_input = File.readlines('input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

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


