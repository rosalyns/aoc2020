example_input = File.readlines('day13/input/example.txt', chomp: true)
input = File.readlines('day13/input/input.txt', chomp: true)

def algorithm(input)
  departure = input[0].to_i
  buses = input[1].split(',')

  buses = buses.reject { |bus| bus == 'x' }.map(&:to_i)
  waiting_times = buses.map { |bus| (departure/bus + 1) * bus - departure }
  puts "minutes to wait #{waiting_times}"
  index = waiting_times.rindex(waiting_times.min)
  bus = buses[index]
  minutes = waiting_times[index]
  puts "bus #{bus} wait for #{minutes} minutes"
  puts bus * minutes
end
