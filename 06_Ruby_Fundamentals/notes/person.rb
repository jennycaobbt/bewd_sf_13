require 'pry'
require 'pry-byebug'


class Person
  #initialize is the constructor
  #getter & setter properties, means we can read and write these attributes for every of these.
  #this can be methods too?

  attr_accessor :name, :age, :home_town

  def initialize(name, age, home_town)
    #instance variable - available everywhere in the class
    @name = name
    @age = age
    @home_town = home_town

  end

  #instance method
  def to_s
    "Hey! I'm a person. My name is #{name}. I am from #{home_town}!"
    #This is super cool!
  end



  def coding_skills
    if home_town == "San Francisco"
      "I have coding skills"
    else
      "I have been deprived of coding skills"
    end
  end

  def new_name
    @name = "John"
  end

  #self means it's a class method
  def self.assess_skills(people)
    people.each do |person|
      puts person.coding_skills
    end
  end


end

def assess_skills(people)
  people.each do |person|
    puts person.coding_skills
  end
end

jenny = Person.new("Jenny", 25, "Toronto")
homura = Person.new("Homura", 26, "Makihara City")
jane = Person.new("Jane", 97, "San Francisco")

people = [jenny, homura, jane]

assess_skills(people)



#puts person.object_id
#puts jenny
#anything that does not have a self, instance method. Available to everyone.


#class method, method that can be called outside of the class and cannot be called by an instance of itself.
#method that has more wholistic jobs. Intract with other classes.
#car.create.
