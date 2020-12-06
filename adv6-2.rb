example_input = File.readlines('adv6-1-input.txt', chomp: true)
input = File.readlines('adv6-1-input2.txt', chomp: true)

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


