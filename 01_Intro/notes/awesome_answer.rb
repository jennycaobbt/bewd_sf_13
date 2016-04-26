require 'pry'
require 'pry-byebug'


def awesome(num)
  if (num % 3 == 0) && (num % 5 == 0)
    puts "Awesome #{num}!"
  elsif num % 3 == 0
    puts "#{num} -> Awe"
  elsif num % 5 == 0
    puts "#{num} -> Some"
  else
    puts "This number is #{num}. It is not completely Awesome"
  end
end

def awesome_seeker(high_number)
  1.upto(high_number) do |number|
    awesome(number)
  end
end

puts "Give me a number"
num1 = gets.to_i

awesome_seeker(num1)
