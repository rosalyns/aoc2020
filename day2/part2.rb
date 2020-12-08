example_input = File.readlines('day2/input/example.txt', chomp: true)
input = File.readlines('day2/input/input.txt', chomp: true)

def algorithm(input)
  valid = 0
  input.each do |line|
    policy = line.split(': ')[0]
    password = line.split(': ')[1]
    limits = policy.split(' ')[0]
    letter = policy.split(' ')[1]
    limit1 = limits.split('-')[0].to_i
    limit2 = limits.split('-')[1].to_i

    valid += 1 if (password[limit1 - 1] == letter) ^ (password[limit2 - 1] == letter)
  end

  puts "valid: #{valid}"
end

