example_input = File.readlines('day1/input/example.txt', chomp: true)
input = File.readlines('day1/input/input.txt', chomp: true)

def algorithm(input)
  input.each_with_index do |number, i|
    input[i..input.length - 1].each_with_index do |number2, i2|
      input[i2..input.length - 1].each do |number3|
        if number + number2 + number3 == 2020
          puts "numbers are #{number} and #{number2} and #{number3}"
          return number * number2 * number3
        end
      end
    end
  end
end