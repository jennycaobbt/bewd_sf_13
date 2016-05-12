require "typhoeus"
require "json"
require "csv"



def connect_to_api(url)
  response = Typhoeus.get(url)
  json_response = JSON.parse!(response.body)#what is body
end


url = "https://www.reddit.com/.json"
json = connect_to_api(url)

#puts json.class

#puts json.keys

#puts json["data"]

#puts json["data"].class

#puts json["data"].keys

#puts json["data"]["children"].first["data"]
