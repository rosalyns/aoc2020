example_input = File.readlines('input/example.txt', chomp: true)
# example_input = File.readlines('day17/input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

def parse(token_stream)
  tree = {}

  while token = token_stream.next
    case token
    when '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
      if tree.key?(:right) && tree[:right].nil?
        tree[:right] = token.to_i
      else
        tree = token.to_i
      end
    when '+', '*'
      tree = {op: token.to_sym, left: tree, right: nil}
    when '('
      sub_tree = parse(token_stream)

      if tree.key?(:right) && tree[:right].nil?
        tree[:right] = sub_tree
      else
        tree = sub_tree
      end
    when ')'
      return tree
    end
  end
rescue StopIteration
  return tree
end

def run(tokens)
  execute(parse(tokens.to_enum))
end

def execute(ast)
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

results = input.map do |line|
  tokens = line.chars.reject { |x| x == ' ' }
  run(tokens)
end

puts results.sum
