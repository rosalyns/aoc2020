example_input = File.readlines('adv4-input.txt', chomp: true)
input = File.readlines('adv4-input2.txt', chomp: true)
valid_input = File.readlines('adv4-2-valid-input.txt',chomp: true)
invalid_input = File.readlines('adv4-2-invalid-input.txt', chomp: true)

def algorithm(input)
  present_fields = []
  valid = 0
  input.each do |line|
    if line.empty?
      valid += 1 if valid(present_fields)
      present_fields = []
      next
    end

    present_fields += line.split(' ').map { |key_value| key_value.split(':') }
  end
  valid += 1 if valid(present_fields)

  puts "valid: #{valid}"
end

def valid(present_values)
  fields = %w[byr iyr eyr hgt hcl ecl pid cid]
  missing_fields = fields - present_values.collect(&:first)
  return false unless missing_fields == %w[cid] || missing_fields.empty?

  present_values.map { |value| valid_field(value) }.all?
end

def valid_field(key_value)
  case key_value[0]
  when 'byr'
    key_value[1].to_i.between?(1920, 2002)
  when 'iyr'
    key_value[1].to_i.between?(2010, 2020)
  when 'eyr'
    key_value[1].to_i.between?(2020, 2030)
  when 'hgt'
    if key_value[1].match(/^(\d+)in$/)
      $1.to_i.between?(59, 76)
    elsif key_value[1].match(/^(\d+)cm$/)
      $1.to_i.between?(150, 193)
    else
      false
    end
  when 'hcl'
    key_value[1].match(/^#[0-9a-f]{6}$/)
  when 'ecl'
    %w[amb blu brn gry grn hzl oth].include?(key_value[1])
  when 'pid'
    key_value[1].match(/^[0-9]{9}$/)
  when 'cid'
    true
  else
    false
  end
end
