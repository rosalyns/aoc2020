example_input = File.readlines('day13/input/example.txt', chomp: true)
input = File.readlines('day13/input/input.txt', chomp: true)

def algorithm(input)
  buses = input[1].split(',')
  offsets = []
  buses = buses.each_with_index { |bus, i| if bus != 'x' then offsets << i end }.reject { |bus| bus == 'x' }.map(&:to_i)
  buses, offsets = buses.zip(offsets).sort_by(&:first).reverse.transpose
  puts "buses #{buses}"
  puts "offsets #{offsets}"

  result = 0

  t = (100000000000000 / buses[0]) * buses[0] - offsets[0]
  # t = -offsets[0]

  while result.zero?
    # puts "t = #{t}"
    count = 0

    buses.each_with_index do |bus, i|
      break if (t + offsets[i]) % bus != 0

      count += 1
    end
    result = t if count == buses.length
    t += buses[0]

    # if t % 1000000 == 0
    #   print "+"
    # end
  end

  puts "result found! #{result}"
end
