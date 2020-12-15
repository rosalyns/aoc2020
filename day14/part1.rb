example_input = File.readlines('day14/input/example.txt', chomp: true)
input = File.readlines('day14/input/input.txt', chomp: true)

def algorithm(input)
  @mask = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
  @mem = {}
  input.each do |line|
    # line.match(/^(mask = )([X10]*)|(mem)\[(\d+)\] = (\d+)$/)
    if line.start_with? 'mask'
      process_mask(line.match(/^mask = ([X10]*)$/).captures)
    else
      process_mem(line.match(/^mem\[(\d+)\] = (\d+)$/).captures)
    end
  end
  puts "sum of mem = #{@mem.values.sum}"
end

def process_mem(args)
  value = '%036b' % args[1]
  one_indices = @mask.size.times.select { |i| @mask[i] == '1'}
  zero_indices = @mask.size.times.select { |i| @mask[i] == '0'}
  mask = @mask.gsub('X','1')
  result = '%036b' % (value.to_i(2) & mask.to_i(2))
  one_indices.each do |i|
    result[i] = '1'
  end
  zero_indices.each do |i|
    result[i] = '0'
  end
  puts "combination #{result.to_i(2)}"
  @mem[args[0]] = result.to_i(2)
end

def process_mask(mask)
  @mask = mask.first
end
