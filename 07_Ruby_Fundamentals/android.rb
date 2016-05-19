require 'pry'
require 'pry-byebug'
require_relative 'robot'


class Android < Robot
  attr_accessor :name, :origin, :type

  def initialize(name, origin, type)
    #override. A subclass of Robot...
    super
  end

end

android = Android
