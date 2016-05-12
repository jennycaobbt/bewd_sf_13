#1 - Pull the json from the reddit API via
  # http://www.reddit.com/.json
  # http://mashable.com/stories.json
#2 - Parse it using the JSON library
#3 - Find the stories based on techniques used in the code_along (max of 25 provided)
#4 - Create a new story hash out of each story with the following keys :title, :upvotes and :category
    #title, #category and #upvotes may not be the names use
#5 - Add each story to an array
#6 - Print each story from the array on your "Front Page"
#7 - BONUS ### create an 'csv' file using the api data & Ruby's CSV library
     # -> http://ruby-doc.org/stdlib-2.2.2/libdoc/csv/rdoc/CSV.html
         #title, upvote, category are the required columns

require 'typhoeus'#library that faciltates http requests
require 'pry'
require 'pry-byebug'
require 'json'
require 'csv'

def connect_to_api(url)
  response = Typhoeus.get(url)
  JSON.parse(response.body)
end


def print_reddit_stories(story_hash)
  story_hash.each do |story|
    puts "Title: #{story[:title]}"
    puts "Upvotes: #{story[:upvotes]}"
    puts "Category: #{story[:category]}"
    puts ""
  end
end

def stories_hash(json_output)
  children = json_output["data"]["children"]
  stories = []

  children.each do |story|
    story_hash={}
    story_hash[:title] = story["data"]["title"]
    story_hash[:upvotes] = story["data"]["ups"]
    story_hash[:category] = story["data"]["subreddit"]
    stories.push(story_hash)
    #binding.pry
  end
  return stories
end




def to_csv(story_hash)
  CSV.open("output_file.csv", "wb") do |csv|
    story_hash.each do |story|
      csv << ["Title:", story[:title]]
      csv << ["Upvotes:", story[:upvotes]]
      csv << ["Category:", story[:category]]
      csv << [" "]
    end
  end
end




reddit_url ='http://www.reddit.com/.json'
reddit_json_response = connect_to_api(reddit_url)

hash = stories_hash(reddit_json_response)
print_reddit_stories(hash)
to_csv(hash)



#children is an array of hashes
#the first child, the hash has 2 keys. 1 is kind, 1 is data, which contains many more hashes.
