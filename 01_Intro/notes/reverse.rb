require 'pry'
require 'pry-byebug'


def my_reverse(thing)
  len = thing.length
  half_length = len/2

  0.upto(half_length) do |num|
    vector1 = thing[num]
    vector2 = thing[-1-num]
    thing[num] = vector2
    thing[-1-num] = vector1
  end

  return thing

end

#   puts "Give me a string"
#   str = gets
#
# my_reverse(str.chomp)

def palend (str)
  puts my_reverse(str.downcase.chars)
  if str == my_reverse(str.downcase.chars)
    puts "This is a palendrome!"
  else
    puts str
    puts my_reverse(str.downcase.chars)
    puts "Not a palendrome"
  end

end

  puts "Give me a string"
  str = gets

  palend(str.chomp)
