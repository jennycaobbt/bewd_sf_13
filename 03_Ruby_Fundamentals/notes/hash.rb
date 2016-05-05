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

#length
puts "LENGTH".green
puts cars.length

#keys
puts "KEYS".green
puts cars.keys

#values_at
puts "VALUES".green
puts cars.values

#merge
puts "MERGE".green
puts cars.merge(pokemon)

#has key
puts cars.has_key? :tesla
puts pokemon.has_value? "Pikachu"

#values at
puts "VALUES AT".green
puts cars.values_at(:tesla, :ford)
