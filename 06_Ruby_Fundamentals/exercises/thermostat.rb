require 'pry'
require 'pry-byebug'
require 'colorize'



class Thermostat

  #creates getter && setter methods for each attribute
  attr_accessor :current_temp
  attr_reader :target

#instance_factory to support creating a new thermostat using Thermostat.new
  def initialize(current_temp, target)
    @current_temp = current_temp
    @target = target
  end

 #self.target , @target and target are all the same inside of this instance method
 #This checks to see if the temperature needs adjusting.
  def calibrate_temp
    if current_temp > target
      decrease_temp
    elsif current_temp < target
      increase_temp
    else
      puts "ahhh.... #{current_temp}... just right!".green
      sleep(0.1)
    end
  end

#This increases the temperature until it reaches the target temp.
  def increase_temp
    puts "It's only #{current_temp} degrees! Let's turn on the heater!".yellow
    if (target - current_temp) >= 5
      adjust_up(5)#will adjust by 5 if the diff is greater than 5
    else
      adjust_up(1)#if diff is less than 5, will only adjust by 1 till it reaches target
    end
    calibrate_temp #Calibrate the temp at the end to see if it's right.
  end

#same as increast temp except decrease.
  def decrease_temp
    puts "#{current_temp} degrees? It's too hot! I'm gonna turn on the AC.".yellow
    if (current_temp-target) >= 5
      adjust_down(5)
    else
      adjust_down(1)
    end
    calibrate_temp
  end


#Methods to actually increase/decrease temp by an X amount.
  def adjust_up(amount)
    puts "...Increasing temperature by #{amount} degrees..."
    self.current_temp = current_temp + amount
  end

  def adjust_down(amount)
    puts "...Decreasing temperature by #{amount} degrees..."
    self.current_temp = current_temp - amount
  end


#Takes an array of temps and target temps, make instances out of them and calibrate them.
  def self.detect_temperature(all_temps, target_temp)
    all_temps.each do |temp|
      instance = Thermostat.new(temp, target_temp)
      instance.calibrate_temp
    end
  end
end

#The temperature is being read externally somewhere, so let's just create an array of those readings
#and pass them into our class method Thermostat.detect_temperature(all_temps, target_temp)

#array_to_temperatures
all_temps = [45,65,85,95, 66, 99, 75, 12, 22, 45, 65, 75, 70, 100, 10, 52, 22]
#set by user
target_temp = 75

Thermostat.detect_temperature(all_temps, target_temp)
