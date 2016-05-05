
#Iterators - Exploring .each
#Does through all of the things in your box, and performs.

#Array v = %w(stuff in here!)

# a block starts with do ends with end, there's a pipe inside.
#another way is curly braces.

fruits = %w(strawberries apple pineapple lemon grapes)
puts fruits

fruits.push("oranges", "watermelon")
puts fruits


fruits.each do |fruit|
  puts fruit.capitalize
end

fruits.each {|brand| puts brand.upcase}
