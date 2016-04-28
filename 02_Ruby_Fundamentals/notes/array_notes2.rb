a = %w{this is an array}

#size
puts "SIZE"
puts a.size

#push
puts "PUSH"
a.push("let's", "add").push("something", "to").push("it")
puts "#{a}"

#<< shovel, adds only 1 thing. when you put in array it will add the array, not 2 items.



#pop - remotes the last element from self and return it. Can define how many elements
puts "POP"
puts a.pop
puts "#{a}"
puts "#{a.pop(3)}"
puts "#{a}"

#unshift adds things to the front of the array
puts "UNSHIFT"
a.unshift("hi")
puts "#{a}"

#removes the first element of self and return it
puts "SHIFT"
puts a.shift
puts "#{a}"

#uniq returns only the elements that are not duplicates, remove duplicates
b = %w{lets create a special special array for this this}
puts "#{b.uniq}"



#include? returns true or false depending on if the parameter's in the array
puts a.include?("array")
puts a.include?("Ruby")
