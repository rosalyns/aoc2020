example_input = File.readlines('input/example.txt', chomp: true)
# example_input = File.readlines('day17/input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

def parse(token_stream)
  tree = {}

  while token = token_stream.peek
    case token
    when '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
      put_right(tree, token.to_i)
      token_stream.next
    when '+'
      tree = {op: token.to_sym, left: tree, right: nil}
      token_stream.next
    when '*'
      tree = {op: token.to_sym, left: tree, right: nil}
      token_stream.next
    when '('
      token_stream.next
      sub_tree = parse(token_stream)
      token_stream.next

      if tree.key?(:right) && tree[:right].nil?
        tree[:right] = sub_tree
      else
        tree = sub_tree
      end
    when ')'
      return tree
    else

      token_stream.next
    end
  end
rescue StopIteration
  return tree
end

def put_right(tree, operand)
  if tree[:right].nil?
    tree[:right] = {op: :is, left: nil, right: operand}
  else
    put_right(tree[:right], operand)
  end
end

def run(tokens)
  puts parse(tokens.to_enum).inspect
  execute(parse(tokens.to_enum))
end

def execute(ast)
  if ast[:op] == :is
    return ast[:right]
  end

  left = if ast[:left].is_a? Numeric
           ast[:left]
         else
           execute(ast[:left])
         end

  right = if ast[:right].is_a? Numeric
            ast[:right]
          else
            execute(ast[:right])
          end


  left.public_send(ast[:op], right)
end

results = example_input.map do |line|
  tokens = line.chars.reject { |x| x == ' ' }
  puts tokens.join
  run(tokens)
end

puts results.sum
