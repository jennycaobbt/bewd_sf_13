require 'pry'
require 'pry-byebug'

<<<<<<< HEAD
#create an apartment class using OOP principles

class Apartment
  attr_accessor :name, :price, :neighborhood, :url, :date

  def initialize (price, neighborhood, name, url, date)
    @price = price
    @neighborhood = neighborhood
    @name = name
    @url = url
    @date = date
  end

  def recommend
    if neighborhood.include?("SOMA")
      return "YES"
    elsif neighborhood.include?("tenderloin")
      return "NO"
    else
      return "N/A"
    end
  end

  def self.average_price(array)
    price_total = 0
    array.each do |apartment|
      string_price = apartment.price
      price_total += string_price[1..-1].to_i
      #binding.pry
    end

    return price_total/array.length
=======
class Apartment
  attr_accessor :name, :url, :price, :neighborhood

  def initialize(name,url,price,neighborhood)
    @name = name
    @url = url
    @price = price
    @neighborhood = neighborhood
>>>>>>> 94deb58b44f79b19c895cafd9592b7b9c62e5494
  end
end
