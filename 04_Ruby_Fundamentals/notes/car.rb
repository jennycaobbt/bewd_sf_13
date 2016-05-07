require 'pry'
require 'colorize'


#---------------------------Supporting Methods-----------------------------

def yes_no (question)
  puts question
  answer = gets.strip.downcase
  if answer == "yes"
    return true
  elsif answer == "no"
    return false
  else
    puts "Sorry, that's an invalid answer. Please enter 'yes' or 'no'"
    yes_no(question)
  end
end

def print_list(list)

list.each do |item|
  puts "ID: #{item[:ID]}"
  puts "Make: #{item[:name]}"
  puts "Model: #{item[:model]}"
  puts "Year: #{item[:year]}"
  puts "Price $#{item[:price]}"
  puts "Color: #{item[:color]}"
  if item[:is_electric] == true
    puts "Fuel: Electric"
  elsif item[:is_electric] == false
    puts "Fuel: Gasoline"
  else
    puts "ERROR!!!!!"
  end
  puts " "
  end
end

def select_car_by_id(id, cars)
  cars.each do |car|
    if car[:ID] == id
      return car
    end
  end
end

#---------------------------Supporting Methods-----------------------------









#---------------------------Retrive Information-----------------------------

def get_year
  puts "What is the lowest year?"
  lowest_year = gets.strip.to_i

  if lowest_year <= 0 || lowest_year >2018
    puts "very funny, that's not a valid year"
    get_year
  else
    puts "Great! We will only show you cars that are made on or after #{lowest_year}"
    return lowest_year
  end
end

def get_price

  puts "What is your price ceiling?"
  price_ceiling = gets.strip.to_i

  if price_ceiling <= 0
    puts "very funny, that's not a valid price"
    get_price
  else
    puts "Great! We will only show you cars that cost less than $#{price_ceiling}"
    return price_ceiling
  end

end

def is_electric

  puts "How do you want your car fueled?"
  puts "electric/gasoline/don't care"

  fuel_option = gets.strip.downcase

  case fuel_option
  when "electric"
    puts "Great! We'll only pick out electric cars for you!"
    return "electric"
  when "gasoline"
    puts "Great! We'll only pick out gasoline based cars for you!"
    return "gasoline"
  when "don't care"
    puts "Not picky I see... noted, we'll show you both kinds of cars then."
    return "both"
  else
    puts "Sorry, I don't understand you, please type in a valid answer"
    is_electric
  end
end

#---------------------------Retrive Information-----------------------------







#---------------------------------Matching---------------------------------

def match (user_criteria, car_lot)
  year = user_criteria[:lowest_year]
  price = user_criteria[:price]
  preference = user_criteria[:electric_pref]

  all_matches_year =  match_year(year, car_lot)
  all_matches_price = match_price(price, car_lot)
  all_matches_elec = match_electric(preference, car_lot)
  all_matches_color= car_lot


  #puts "Matched year:".green
  #print_list(all_matches_year)
  #puts "Matched price:".green
  #print_list(all_matches_price)
  #puts "Matched elec:".green
  #print_list(all_matches_elec)
  puts "...... searching........"
  sleep(0.5)
  puts "...... searching........"
  sleep(0.5)
  puts "...... searching........"
  sleep(0.5)
  all = intersec(all_matches_year, all_matches_price, all_matches_elec, all_matches_color, car_lot, "none")

  puts "There are #{all.length} cars that matches your criteria."
  print_list(all)

  if all.length == 0
    sales_department(all_matches_year, all_matches_price, all_matches_elec, all_matches_color, car_lot)
  else
    sale_status = ask_for_sale(all)

    if sale_status == "sale"
      puts "Thanks for shopping!"
    elsif sale_status == "no sale"
      sales_department(all_matches_year, all_matches_price, all_matches_elec, all_matches_color, car_lot)

    else
      puts "ERROR!!!"
    end
  end

end


def flex_match(year, price, elec, color, car_lot)
  flex_color = yes_no("Do you have any flexiblity in the color of the car?")
  flex_elec = yes_no("What about the fuel source?")
  flex_year = yes_no("Do you have flexiblity on the year the car was made?")
  flex_price = yes_no("Finally, do you have any flexibility on price?")

  flex = []
  if flex_color == true
    flex.push("color")
  end

  if flex_elec == true
    flex.push("elec")
  end

  if flex_price == true
    flex.push("price")
  end

  if flex_year == true
    flex.push("year")
  end

  new_match = intersec(year, price, elec, color, car_lot, flex)
  puts "Here are some new matches based on your flexibility:"
  print_list(new_match)
  return new_match

end


def intersec (year, price, elec, color, all, flex)
  if flex.include? "color"
    color = all
  end

  if flex.include? "elec"
    elec = all
  end

  if flex.include? "price"
    price = all
  end

  if flex.include? "year"
    year = all
  end

  intersec = year & price & elec & color

end

def match_year (year, car_lot)
  valid_cars = []
  car_lot.each do |car|
    if car[:year]>=year
      valid_cars.push(car)
    end
  end
  return valid_cars
end


def match_price (price, car_lot)
  valid_cars = []
  car_lot.each do |car|
    if car[:price] <= price
      valid_cars.push(car)
    end
  end
  return valid_cars
end


def match_electric (preference, car_lot)
  valid_cars=[]
  case preference
  when "electric"
    car_lot.each do |car|
      if car[:is_electric] == true
        valid_cars.push(car)
      end
    end
    return valid_cars
  when "gasoline"
    car_lot.each do |car|
      if car[:is_electric] == false
        valid_cars.push(car)
      end
    end
    return valid_cars
  when "both"
    return car_lot
  else
    puts "else"
  end

end

#---------------------------------Matching---------------------------------





#----------------------------------Sales----------------------------------
def ask_for_sale(cars)


  buy_decision = yes_no("Would you like to buy one of these cars? (yes/no)")

  if buy_decision == true
      return get_id(cars)

  else
    return "no sale"

  end
end

def get_id(cars)
  car_ids = []
  cars.each do |car|
    car_ids.push(car[:ID])
  end
  puts "Please enter the ID associated with your purchase:"
  id = gets.strip.to_i


  if car_ids.include?(id)

    the_car = select_car_by_id(id, cars)

    if the_car[:is_electric] == true
      fuel = "electric"
    else
      fuel = "gasoline"
    end

    puts "So the #{the_car[:color]} #{the_car[:name]} #{the_car[:model]} using #{fuel} fuel?"
    puts "That will be $#{the_car[:price]} please!"
    final_confirm = yes_no("Are you sure you want to buy this car? (yes/no)")
    if final_confirm == true
      puts "Thanks you for buying the #{the_car[:color]} #{the_car[:name]} #{the_car[:model]} using #{fuel} fuel!"
      puts "I am now $#{the_car[:price]} richer!"
      return "sale"
    else
      return "no sale"
    end
  else
    puts "Sorry, that's not a valid ID."
    get_id(cars)
  end
end




def sales_department(year, price, elec, color, car_lot)
  puts "Wait! We might have more matches for you if you have a little flexibiilty in your criteria!"
  try_more = yes_no("Do you want to keep looking for cars?")

  if try_more == true
    new_match = flex_match(year, price, elec, color, car_lot)
    ask_for_sale(new_match)

  else
    puts "Alright, thanks anyways.... I guess.... "
  end

end

#----------------------------------Sales----------------------------------






#------------------------------Body of the code------------------------------


car_lot = []
tesla = {ID: 1001,name: "Tesla", model: "Model X", year: 2017, is_electric: true, price: 45000, color: "black"}
jeep = {ID: 1002,name: "Jeep", model: "Grand Cherokee", year: 2004, is_electric: false, price: 37000, color: "white"}
porsche = {ID: 1003,name: "Porsche", model: "Speedster", year: 1955, is_electric: false, price: 65000, color: "yellow"}
ford = {ID: 1004,name: "Ford", model: "Fusion", year: 2003, is_electric: false, price: 18000, color: "red"}
toyota = {ID: 1005, name: "Toyota", model: "Prius", year: 2010, is_electric: true, price: 24000, color: "silver"}

car_lot.push(tesla, jeep, porsche, ford, toyota)

user_criteria = {}

puts "Please enter your criteria"
user_criteria[:lowest_year] = get_year
user_criteria[:price] = get_price
user_criteria[:electric_pref] = is_electric


match(user_criteria, car_lot)

#-----------------------------Body of the code end----------------------------
