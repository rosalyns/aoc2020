example_input = File.readlines('adv6-1-input.txt', chomp: true)
input = File.readlines('adv6-1-input2.txt', chomp: true)

def algorithm(input)
  sum = 0
  letters = []
  input.each_with_index do |line, i|
    letters += line.scan /\w/

    if line.empty? || (i == input.length - 1)
      sum += letters.uniq.count
      # puts "add #{letters.uniq.count}"
      letters = []
    end
  end

  puts "sum #{sum}"
end


