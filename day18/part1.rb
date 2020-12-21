example_input = File.readlines('input/example.txt', chomp: true)
# example_input = File.readlines('day17/input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

answers = []

def get_closing_bracket_index(expr)
  closing = expr.length.times.select { |i| expr[i] == ')' }
  opening = expr.length.times.select { |i| expr[i] == '(' }
  count_open = 0
  count_closed = 0
  closing_index = -1
  expr.length.times do |i|
    if opening.include?(i)
      count_open += 1
      closing_index += 1
    elsif closing.include?(i)
      count_closed += 1
    end
    return closing[closing_index] if count_open == count_closed
  end
  closing[closing_index]
end

def parse(expr)
  puts "expr #{expr}"
  if expr.length == 1
    expr[0].to_i
  elsif expr[0] == '('
    closing_index = get_closing_bracket_index(expr)
    parse([parse(expr[1..closing_index - 1]).to_s] + expr[closing_index + 1..expr.length - 1])
  elsif expr[0].match(/\d+/) && expr.length == 3
    expr[0].to_i.public_send(expr[1], expr[2].to_i)
  elsif expr[0].match(/\d+/) && expr.length > 3
    third_char = expr[2]
    if third_char == '('
      closing_index = get_closing_bracket_index(expr)
      parse([expr[0].to_i.public_send(expr[1], parse(expr[2..closing_index])).to_s] + expr[closing_index + 1..expr.length - 1])
    elsif third_char.match(/\d+/)
      parse([expr[0].to_i.public_send(expr[1], expr[2].to_i).to_s] + expr[3..expr.length - 1])
    end
  end
end

example_input.each do |line|
  expr = line.chars.reject { |char| char == ' ' }
  answer = parse(expr)
  puts "Found answer: #{answer}"
  answers << answer
end

puts "answers #{answers.sum}"