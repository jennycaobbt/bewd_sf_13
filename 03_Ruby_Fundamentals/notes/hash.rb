require 'colorize'

cars = {}
puts cars

cars[:tesla] = {year: 2016, model: "Model X", price: "80000"}
puts cars
cars[:ford] = {year: 1967, model: "Mustang", price: "30000"}
puts cars
puts cars.keys

pokemon = {name: "Pikachu", type: "Electric", level: 20}


#.length
#.merge and merge!
#.select
#.keys, .values
#.values, values_at
#.has_key?, .has_value?

#length - find the length
puts "LENGTH".green
puts cars.length

#keys - return the keys in an array
puts "KEYS".green
puts cars.keys

#values_at - return the values in an array
puts "VALUES".green
puts cars.values

#merge - merge 2 hashes together, if there's duplicate keys take the most recent one, eg. from the second  hashes
puts "MERGE".green
puts cars.merge(pokemon)

#has key - return true or false depending on if the hash has the key
puts cars.has_key? :tesla
puts pokemon.has_value? "Pikachu"

#values at - return the value based on the key
puts "VALUES AT".green
puts cars.values_at(:tesla, :ford)

#select - return a new hash based on conditions
puts "SELECT".green
puts cars.select{|k,v| v[:year] == 1967}

#.to_a - change it to an array
puts "TO A".green
puts pokemon.to_a

puts cars[:tesla].length
