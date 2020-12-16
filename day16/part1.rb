example_input = File.read('input/example.txt')
input = File.read('input/input.txt')

rules = {}
errors = []

data = input.split("\n\n")
rules_string = data[0]
rules_string.split("\n").each do |rule|
  captures = rule.match(/^(.*): (\d+)-(\d+) or (\d+)-(\d+)/).captures
  rules[captures[0]] = (captures[1].to_i..captures[2].to_i).to_a + (captures[3].to_i..captures[4].to_i).to_a
end

tickets_string = data[2]
tickets_string.split("\n").each do |ticket|
  next if ticket == 'nearby tickets:'

  ticket.split(',').each do |number|
    errors << number.to_i unless rules.values.flatten.uniq.include? number.to_i
  end
end

puts errors
puts "sum = #{errors.sum}"
