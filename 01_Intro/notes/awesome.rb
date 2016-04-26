require 'pry'
require 'pry-byebug'

def awesome(number)
  if number == 3
    puts "Yes"
  else
    puts "No"
  end   #second end is required!
end

awesome(3)
