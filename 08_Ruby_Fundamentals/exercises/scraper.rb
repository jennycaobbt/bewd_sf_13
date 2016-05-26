<<<<<<< HEAD
require 'pry'
require 'pry-byebug'
require 'mechanize'
require 'csv'
require_relative 'apartment.rb'

#Goal:
   #1) Find apartment listings section of craigslist using the 'mechanize' gem
       #a Use the existing form's 'query', 'min_price' and 'max_price' to trigger queries.
       #b Return the title, url, price and location for each listing
   #2)  Save the results to a CSV file using Ruby's 'csv' library
   #3) Use OOP, DRY and 'Brick By Brick' principles to build your script
       #Using the apartment.rb file to create an instance of each

#sample_apartment_url 'http://sfbay.craiglist.org/search/sfc/apa'
def scrape(url, name, min_price, max_price)

  scrape = Mechanize.new #creates unique IDs of everything on the page. Creates instance of everytyig on page.
  scraper = scrape.history_added = Proc.new { sleep 1.0 }
  #binding.pry
  scrape.get(url) do |page|

    #what is the form equals doing??? Overriding, some of the values that mechanize given us.
    #we can modify an array like this?

    #finding all data within searchform area of the view layer
    form = page.form_with(id: 'searchform') do |s| #zeroing in on input field.
      #assigning new values to query, min_price, and max_price.
      s['query'] = name #name
      s['min_price'] = min_price.to_i #Hashes.
      s['max_price'] = max_price.to_i
    end
    data = form.submit #look for submit, how does it know which one to click?
    #submitting search request. Submit the data of the form.
    data_results(data)
=======
require 'mechanize'
require 'csv'
require 'pry-byebug'
require_relative 'apartment'

def scrape_connect
  Mechanize.new
end

def search_results(form)
  page = form.submit
  raw_results = page.search('p.row')
  return raw_results
end

def scrape_it(url,query_name,max_price,min_price)
  scrape_connect.history_added = Proc.new { sleep 5.0} #prevents lock_out

  scrape_connect.get(url) do |search_page|
    form = search_page.form_with(id: 'searchform') do |search|
      search['query'] = query_name
      search['min_price'] = min_price.to_i
      search['max_price'] = max_price.to_i
    end
    raw_results = search_results(form)
    parse_results(raw_results)
>>>>>>> 94deb58b44f79b19c895cafd9592b7b9c62e5494
  end
end


<<<<<<< HEAD
#This fetches the data based on the search criteria and return an array of apartments.
def data_results(data)
 #data search p row. Creates a tree pattern that mirrors the html.
  results = data.search('p.row')

  apartments = []
  results.each do |listing| #listing is a bunch of data for each p row.
    apartments.push(create_apartment(listing))
  end
  create_csv(apartments) #list of apartments here.
end

def create_csv(apartments) #passes array of objects - apartments.

  CSV.open("apartments.csv", "wb") do |csv|
    csv << ["Date", "Name", "Neighborhood", "Price", "URL", "Recommend?"]
    apartments.each do |apartment|
      csv << [apartment.date, apartment.name, apartment.neighborhood, apartment.price, apartment.url, apartment.recommend]
    end
    puts Apartment.average_price(apartments)
    csv << ["Average Price:", Apartment.average_price(apartments)]
  end
end

def create_apartment(listing)
#  binding.pry
  price = listing.search('span.price').text
  neighborhood = listing.search('span.pnr').text.strip
  url = listing.css('a')[1].attributes["href"].value #just the endpoint, create complete url.
  name = listing.search('span.pl').text.strip

  date = name[29, 6]
  name = name[36..-1]
  neighborhood = neighborhood[0..-11]
  url.prepend("http://sfbay.craigslist.org")

  Apartment.new(price, neighborhood, name, url, date)
end



url = "http://sfbay.craiglist.org/search/sfc/apa"

puts "Please enter what you want to search for"
name = gets.strip
puts "Please enter your minimum price"
min_price = gets.strip
puts "Please enter your maximum price"
max_price = gets.strip
scrape(url, name, min_price, max_price)
=======
def parse_results(raw_results)
  results = []
  results << ['Name', 'URL', 'Price', 'Neighborhood']

  raw_results.each do |result|
    link = result.css('a')[1]

    name = link.text.strip
    url = "http://sfbay.craigslist.org" + link.attributes["href"].value
    price = result.search('span.price').text
    neighborhood = result.search('span.pnr').text[3..-13]

    puts "This apartment is located in #{neighborhood}"
    apartment = Apartment.new(name,url,price,neighborhood)
    results << [apartment.name, apartment.url, apartment.price, apartment.neighborhood]

    create_csv(results)
  end
end

def create_csv(results)
  CSV.open("apartment_list.csv", "w+") do |csv_file|
    results.each do |row|
      csv_file << row
    end
  end
end


#Provide Dynamic search & url info
url = 'http://sfbay.craigslist.org/search/sfc/apa'
query_name = "Loft"
min_price = 1000
max_price = 5000

#Run Script
scrape_it(url,query_name,max_price,min_price)
>>>>>>> 94deb58b44f79b19c895cafd9592b7b9c62e5494
