name = "Jenny"
intro = "I am "
stuff = ". I am awesome"

#1. Length method returns the length of the string
puts "LENGTH"
puts "The length method returns the length of the string: #{name}, which is #{name.length}"

#2. reverse method returns the string reversed
puts "REVERSE"
puts "The reverse method returns a reversed version of the string, so #{name} will be #{name.reverse}"

#3. prepend adds the parameter you pass it to the front of the string
puts "PREPEND"
namedummy = "Jenny"
puts "The prepend method will attach the parameter you give it to the front of the string."
puts "So prepending the string:"
puts intro
puts "to the string:"
puts name
puts "will make it #{namedummy.prepend(intro)}"

#this thing: << appends its parameter to the string
puts "<< APPEND"
puts "The << method is the append method, it will append the parameter you give it to the end of the string"
puts "So appending the string #{stuff} to the string #{namedummy} will become #{namedummy << stuff}"

#strip gets rid of white spaces!
white_spacy_string = "       hi, I have so much white space around me!          "
puts "The strip method gets rid of white space"

puts "So: #{white_spacy_string}"
puts "Will become"
puts white_spacy_string.strip

#chars turns the string into an array
puts "chars method turns the string into an array, doing that to the now modified name string: #{name} will get you,"
puts name.chars
