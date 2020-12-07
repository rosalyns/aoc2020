example_input = File.readlines('input/example.txt', chomp: true)
input = File.readlines('input/input.txt', chomp: true)

def algorithm(input)
  input.each_with_index do |number, i|
    input[i..input.length - 1].each do |number2|
      if number + number2 == 2020
        puts "numbers are #{number} and #{number2}"
        return number * number2
      end
    end
  end
end
