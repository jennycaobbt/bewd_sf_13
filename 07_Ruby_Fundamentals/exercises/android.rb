require 'pry'
require 'pry-byebug'
require_relative 'robot'

class Android < Robot
  #creates getter && setter methods for each attribute
  attr_accessor :name, :type, :origin, :language

  #instance_factory to support creating a new person using Person.new
  def initialize(name,origin,language = "English")
    super #put whatever's in the constructor of the parent class here. Figure this out a bit more.
    @type = "Android"
    @language = language
  end


end

  android = Android.new("Kisha", "Brooklyn")
  binding.pry
  android.respond_to?(:flying_skills)
