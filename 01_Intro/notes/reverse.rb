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

  puts thing
end

my_reverse("whatisthis?")

# def palend (str)
#   if str == str.reverse
#     puts "This is a palendrome!"
#   else
#     puts str
#     puts str.reverse
#     puts "Not a palendrome"
#   end
#
# end
#
#   puts "Give me a string"
#   str = gets
#
#   palend(str.chomp)
