#categories ={}
#categories[:sports] = {agent: "Jerry Mcquire", slogan: "Show me the money"}
#categories[:music] = {agent: "Lyor Cohen", slogan: "It doesn't matter"}

#do end correspond to the {}
#categories.each {|k, v| puts "#{v}" if v[:agent] == "Jerry Mcquire"}


#boba = {}
#boba[:jasmine] = {price: 4.50, rating: 5, tea: "green"}
#boba[:classic] = {price: 5.00, rating: 4, tea: "black"}
#boba[:fruit] = {price: 4.00, rating: 4, tea: "black"}

car_lot = []
tesla = {name: "Tesla", model: "Model X", year: 2017}
prosche = {name: "Porsche", model: "Speedster", year: 1955}
mustang = {name: "Mustang", model: "GT", year: 1965}

car_lot.push(tesla, prosche, mustang)

car_lot.each do |car|
  puts car[:name]
end


#name, model, year, color, is electric, price,
