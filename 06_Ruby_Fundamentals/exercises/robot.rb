#Classes have state and behavior
#State & Object Factory: factory that creates and instiantes robots
#Behavior: Collection of class methods, instance methods, instance variable, local variables, constants etc.,



#We have 3 types of robots
#3 names
#3 potential origins.
#give certain robots certain skills and other robots other skillz.
#print out a little bit about each robot.


#V1: Create robots based on attributes, save them to file. Log in again.
#V2: Battle random bots.

require 'pry'
require 'pry-byebug'

class Part

  def initialize
  end

end

class Robot

  #creates getter && setter methods for each attribute
  attr_accessor :name, :type, :level, :experience, :attack_ranged, :attack_melee, :defense, :flight, :sprit_power, :max_health, :empathy, :variance, :temp_health, :temp_ranged, :temp_melee, :temp_sprit, :temp_defense

 #instance_factory to support creating a new robot using Robot.new
  def initialize(name,type)
    @name = name
    @type = type
    @level = 1
    @experience = 0
    @attack_ranged = nil
    @attack_melee = nil
    @defence = nil
    @flight = nil #yes or no
    @sprit_power = nil
    @max_health = nil
    @empathy = nil
    @ranged_evasion = nil
    @melee_evastion = nil

    @temp_health = nil
    @temp_ranged = nil
    @temp_melee = nil
    @temp_sprit = nil
    @temp_defense = nil


    generate_stats
    full_heal
  end



  def full_heal

    self.temp_health = max_health
    self.temp_ranged = ranged_attack
    self.temp_melee = melee_attack
    self.temp_sprit = sprit_power
    self.temp_defense = defense
  end

  def make_variance
    rand(5)-2
  end

  def make_small_variance
    rand(3)-1
  end

  def make_large_variance
    rand(21)-10
  end



  def generate_stats
    case self.type
    when "MTB"
      self.attack_ranged = 55 + make_variance
      self.attack_melee = 60 + make_variance
      self.defense = 20 + make_small_variance
      self.flight = false
      self.sprit_power = 20 + make_variance
      self.max_health = 200 + make_large_variance
      self.ranged_evasion = 5
      self.melee_evasion = 6
      self.empathy = 5

    when "RKS"
      self.attack_ranged = 35 + make_variance
      self.attack_melee = 75 + make_variance
      self.defense = 30 + make_small_variance
      self.flight = false
      self.sprit_power = 20 + make_variance
      self.max_health = 250 + make_large_variance
      self.ranged_evasion = 5
      self.melee_evasion = 6
      self.empathy = 7

    when "TLZ"
      self.attack_ranged = 35 + make_variance
      self.attack_melee = 50 + make_variance
      self.defense = 40 + make_small_variance
      self.flight = false
      self.sprit_power = 20 + make_variance
      self.max_health = 350 + make_large_variance
      self.ranged_evasion = 5
      self.melee_evasion = 6
      self.empathy = 3

    when "SMD"
      self.attack_ranged = 45 + make_variance
      self.attack_melee = 55 + make_variance
      self.defense = 10 + make_small_variance
      self.flight = true
      self.sprit_power = 50 + make_variance
      self.max_health = 200 + make_large_variance
      self.ranged_evasion = 10
      self.melee_evasion = 60
      self.empathy = 1

    when "NTN"
      self.attack_ranged = "N/A"
      self.attack_melee = "N/A"
      self.defense = 20 + make_small_variance
      self.flight = false
      self.sprit_power = 100 + make_variance
      self.max_health = 220 + make_large_variance
      self.ranged_evasion = 5
      self.melee_evasion = 6
      self.empathy = 9
    end

  end


  def display_stats

    puts "Name: #{name}"
    puts "Model: #{type}"
    puts "Description: #{describe(type)}"
    puts "-------------"
    puts "STATS:"
    puts "-------------"
    puts "Max Health: #{max_health}"
    puts "Ranged Attack: #{attack_ranged}"
    puts "Melee Attack: #{attack_melee}"
    puts "Defense: #{defense}"
    if flight == true
      puts "Able to Fly: Yes"
    else
      puts "Able to Fly: No"
    end
    puts "Sprit Power: #{sprit_power}"

  end


  #class methods can be called outside of the class like Robot.make_robots(number)

#BATTLE
#----------------


  def battle_random_bot

  end

  def battle(me, enemy)
    puts "Your enemy is #{enemy.name}, a #{enemy.type} BattleBot."
    puts "Entering Battle..."

    result = battle_loop(me, enemy)

    puts result

  end

  def battle_loop(me, enemy)
    attack = choose_attack
    puts "#{name} used the #{attack} attack!"
    enemy_attack = enemy.choose_attack_random
    puts "Your enemy #{enemy.name} used the #{enemy_attack} attack!"

    case attack
    when "ranged"
       base = me.ranged_attack

    when "melee"

    else

    end


  #I calculate result to stats to each bot

  end



  def choose_attack_random
    basic = ["ranged", "melee"]
    full_list = basic
    return full_list.sample
  end


  def choose_attack
    basic = ["ranged", "melee"]
    full_list = basic
    puts "Please choose from one of the following attacks for #{name}:"
    Robot.print_array(full_list)
    choice = Robot.choose(full_list)
    return choice
  end



  def ranged_evasion
    case
  end

  def melee_evasion
  end

#END BATTLE
#------------------------

  def describe(model)
    case model
    when "MTB"
      return "The MTB Model is a moderately sturdy BattleBot that specializes in ranged combat \n
        While it's melee attacks are strong (melee attacks tend to be stronger than ranged), \n
        it has the potential to dish out massive damage with the right ranged weapon. \n
        Ranged attacks are versitile and is able to hit any type of enemy easily. \n
        MTBs are especially strong against SMD bots as it renders their biggest strength, \n
        high evasion against melee, useless.\n
        It is playful with an average amount of empathy"
    when "RKS"
      return "The RKS Model is very strudy (high in defense), this BattleBot specializes \n
        in dishing out TONS of damange with Melee attacks, but strugges against flyers as \n
        their ranged attacks are usually quite weak. However, it is very strudy second \n
        only to the TLZ. \n
        It is very respectful and therefore has above average empathy"
    when "TLZ"
      return "The great TLZ is the tank of the BattleBot world. It has the highest defense \n
        amongst all its peers. However, its attack is relatively low. It has a high health pool\n
        so it is very good in a battle of attrition such as with the NTN \n
        Being a huge chunk of metal means it's not very smart, has below average empathy"
    when "SMD"
      return "The SMD is the agile flyer. It is the only BattleBot with the flight ability \n
        which gives it a very high evasion against ranged attacks, and just high evastion \n
        in general. Its attacks are pretty average but it's a bit fragile when you actually \n
        manage to hit it. It also has relatively more sprit power so it can use more \n
        special moves. \n
        Uh... it's kind of a jerk... not very empathetic :("
    when "NTN"
      return "The NTN is the spirtual healer. In fact, it has no attacks! Its battle \n
        plan is very much different from that of other BattleBots. 'Sprit Wave', \n
        the ability exclusive to the NTN models will deactivate your opponent's \n
        BattleBot when it is at full charge, the NTN will have access to a variety of \n
        abilities to stay alive until Sprit Wave's charge is full. NTN also has \n
        more spirt power than all other bots so it can use various abilities to\n
        help it stay alive that the other bots probably can't afford to do. \n
        As you might expect, the NTN is absolutely a saint and has the highest empahty :)"
    else
    end
  end

  def self.random_robot_maker(name)
    possible_models = ["MTB", "RKS", "TLZ", "SMD", "NTN"]
    Robot.new(name, possible_models.sample)
  end

  def self.generate_name
    possible_names = ["AlphaGo", "CC_4252", "Alter Ego", "BB9", "R2D2", "KnightMare", "Gundam", "Optimus Prime", "Metabee"]
    return possible_names.sample
  end


  def self.get_name
    puts "Let's make a new BattleBot for you!"
    puts "What do you want to name it?"
    name = gets.strip.downcase.capitalize
    puts "You named your new BattleBot #{name}!"
    return name
  end
end


#Support methods

def self.print_array(array)
  array.each do |item|
    puts ">> #{item}"
  end
end

def self.choose (array)
  choice = gets.strip.downcase
  if array.include?(choice)
    return choice
  else
    puts "sorry, this input is invalid, please choose from the available choices"
    Robot.choose(array)
  end
end



#-----------
bot = Robot.random_robot_maker(Robot.get_name)
bot.display_stats
puts bot.choose_attack
