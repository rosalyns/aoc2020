example_input = File.read('input/example2.txt')
input = File.read('input/input.txt')

rules = {}
data = input.split("\n\n")
rules_string = data[0]
rules_string.split("\n").each do |rule|
  captures = rule.match(/^(.*): (\d+)-(\d+) or (\d+)-(\d+)/).captures
  rules[captures[0]] = (captures[1].to_i..captures[2].to_i).to_a + (captures[3].to_i..captures[4].to_i).to_a
end

tickets_string = data[2]
valid_tickets = tickets_string.split("\n").reject do |ticket|
  ticket == 'nearby tickets:' || (ticket.split(',').map(&:to_i) - rules.values.flatten.uniq).any?
end

places = {}
valid_tickets.each do |ticket|
  numbers = ticket.split(',').map(&:to_i)
  numbers.each_with_index do |number, i|
    places[i] ||= []
    places[i] += [numbers[i]]
  end
end

order_options = {}
places.each do |occurrence|
  rules.each do |rule|
    puts "occurrence #{occurrence} rule #{rule}"
    if (occurrence[1] - rule[1]).empty?
      order_options[rule[0]] ||= []
      order_options[rule[0]] += [occurrence[0]]
    end
  end
end

puts order_options

# result by hand
# {"departure location"=>[16],
# "departure station"=>[3],
# "departure platform"=>[11],
# "departure track"=>[17],
# "departure date"=>[4],
# "departure time"=>[ 5],
# "arrival station"=>[14],
# "arrival track"=>[12],
# "class"=>[19],
# "price"=>[ 6],
# "row"=>[ 2],
# "wagon"=>[9],
# "zone"=>[8],
# "arrival location"=>[18],
# "type"=>[15],
# "duration"=>[1],
# "arrival platform"=>[7],
# "train"=>[0],
# "seat"=>[10],
# "route"=>[13]}