example_input = File.readlines('day14/input/example2.txt', chomp: true)
input = File.readlines('day14/input/input.txt', chomp: true)

def algorithm(input)
  @mask = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
  @mem = {}
  input.each do |line|
    if line.start_with? 'mask'
      process_mask(line.match(/^mask = ([X10]*)$/).captures)
    else
      process_mem(line.match(/^mem\[(\d+)\] = (\d+)$/).captures)
    end
  end
  puts "sum of mem = #{@mem.values.sum}"
end

def process_mem(args)
  address = '%036b' % args[0]
  x_indices = @mask.size.times.select { |i| @mask[i] == 'X' }
  one_indices = @mask.size.times.select { |i| @mask[i] == '1' }
  mask = @mask.gsub('0', '1').gsub('X', '1')

  result_address = '%036b' % (address.to_i(2) & mask.to_i(2))
  one_indices.each do |i|
    result_address[i] = '1'
  end
  x_indices.each do |i|
    result_address[i] = 'X'
  end

  all_addresses(result_address).each do |addr|
    @mem[addr] = args[1].to_i
  end
end

def process_mask(mask)
  @mask = mask.first
end

def all_addresses(addr_x)
  swap_all = Hash.new { |_, k| [k] }.merge('X' => ['0', '1'])
  arr = swap_all.values_at(*addr_x.chars)
  arr.shift.product(*arr).map(&:join)
end
