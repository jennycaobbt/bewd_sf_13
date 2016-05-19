#Classes have state and behavior
#State & Object Factory: factory that creates and instiantes robots
#Behavior: Collection of class methods, instance methods, instance variable, local variables, constants etc.,


#V1: Create robots based on attributes, save them to file. Log in again.
#V2: Battle random bots.

require 'pry'
require 'pry-byebug'
require 'colorize'

class Part

  def initialize
  end

end

class Robot

  #creates getter && setter methods for each attribute
  attr_accessor :name, :type, :level, :experience, :attack_ranged, :attack_melee, :defense, :flight, :sprit_power, :max_health, :empathy, :variance, :temp_health, :temp_ranged, :temp_melee, :temp_sprit, :temp_defense, :ranged_evasion, :melee_evasion

  #this is a method that only takes in sympols.
  #getting - read access
  #setter - write access

 #instance_factory to support creating a new robot using Robot.new

  def initialize(name,type, saved = "no")
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
    @ranged_evasion = nil
    @melee_evasion = nil

    @temp_health = nil
    @temp_ranged = nil
    @temp_melee = nil
    @temp_sprit = nil
    @temp_defense = nil

    if saved == "no"
      generate_stats
    else
      #binding.pry
      self.level = saved["level"].to_i
      self.experience = saved["experience"].to_i
      self.attack_ranged =saved["attack_ranged"].to_i
      self.attack_melee = saved["attack_melee"].to_i
      self.defense = saved["defense"].to_i
      if saved["flight"] == "true"
        self.flight == true
      else
        self.flight == false
      end
      self.sprit_power = saved["sprit_power"].to_i
      self.max_health = saved["max_health"].to_i
      self.ranged_evasion = saved["ranged_evasion"].to_i
      self.melee_evasion = saved["melee_evasion"].to_i
    end
    full_heal
  end



  def full_heal

    self.temp_health = max_health
    self.temp_ranged = attack_ranged
    self.temp_melee = attack_ranged
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


    when "RKS"
      self.attack_ranged = 35 + make_variance
      self.attack_melee = 75 + make_variance
      self.defense = 30 + make_small_variance
      self.flight = false
      self.sprit_power = 20 + make_variance
      self.max_health = 250 + make_large_variance
      self.ranged_evasion = 5
      self.melee_evasion = 6


    when "TLZ"
      self.attack_ranged = 35 + make_variance
      self.attack_melee = 50 + make_variance
      self.defense = 40 + make_small_variance
      self.flight = false
      self.sprit_power = 20 + make_variance
      self.max_health = 350 + make_large_variance
      self.ranged_evasion = 5
      self.melee_evasion = 6


    when "SMD"
      self.attack_ranged = 45 + make_variance
      self.attack_melee = 55 + make_variance
      self.defense = 10 + make_small_variance
      self.flight = true
      self.sprit_power = 50 + make_variance
      self.max_health = 200 + make_large_variance
      self.ranged_evasion = 10
      self.melee_evasion = 60

    when "NTN"
      self.attack_ranged = 0
      self.attack_melee = 0
      self.defense = 20 + make_small_variance
      self.flight = false
      self.sprit_power = 100 + make_variance
      self.max_health = 220 + make_large_variance
      self.ranged_evasion = 5
      self.melee_evasion = 6
    end

  end


  def display_stats

    puts "Name: #{name}"
    puts "Level: #{level}"
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
    enemy = Robot.random_robot_maker(Robot.generate_name)

    self.battle(enemy)

  end

  def battle(enemy)
    puts "Your enemy is #{enemy.name}, a level #{enemy.level} #{enemy.type} BattleBot."
    enemy.display_stats
    puts "Entering Battle..."

    result = battle_loop(enemy)

    return result

  end

  def battle_loop(enemy)
    attack = choose_attack
    puts "#{self.name} used the #{attack} attack!"
    enemy_attack = enemy.choose_attack_random
    puts "Your enemy #{enemy.name} used the #{enemy_attack} attack!"

#NTR attacks
  if self.type == "NTN"
    passive_damage = (enemy.max_health * level/25 + 20) - enemy.defense
    #binding.pry
    if passive_damage <= 0
      passive_damage = 1
    end
    enemy.temp_health = enemy.temp_health - passive_damage
    puts "Your opponent took #{passive_damage} of passive damange from #{self.name}'s Sprit Wave."
    puts "it's now at #{enemy.temp_health} health!"
  end

  if enemy.type == "NTN"
    #binding.pry
    passive_damage = (self.max_health * enemy.level/25 + 20) - self.defense
    if passive_damage <= 0
      passive_damage = 1
    end
    self.temp_health = self.temp_health - passive_damage
    puts "#{self.name} took #{passive_damage} of passive damange from Your opponent's Sprit Wave."
    puts "it's now at #{self.temp_health} health!"
  end

#end NTR attacks


#---Calculating your attack-------

    case attack
    when "ranged"
      if Robot.is_hit(enemy.ranged_evade) == true
        #puts "my attack ranged #{self.attack_ranged}"
        #puts "enemy defense #{enemy.defense}"
        damage = self.attack_ranged - enemy.defense
        if damage <= 0
          damage = 1
        end
        #puts "Enemy health #{enemy.temp_health}"
        enemy.temp_health = enemy.temp_health - damage
        puts "#{enemy.name} took #{damage} damage!"
      else
        puts "You missed!"
      end

    when "melee"
      if Robot.is_hit(enemy.melee_evade) == true
        #puts "my attack melee #{self.attack_melee}"
        #puts "enemy defense #{enemy.defense}"
        damage = self.attack_melee - enemy.defense
        if damage <= 0
          damage = 1
        end

        #puts "Enemy health #{enemy.temp_health}"
        enemy.temp_health = enemy.temp_health - damage
        puts "#{enemy.name} took #{damage} damage!"

      else
        puts "You missed!"
      end


    else
      binding.pry
    end
#----End of your attack----


#---Calculating opponent's attack-------
    case enemy_attack
    when "ranged"
      if Robot.is_hit(self.ranged_evade) == true
        #puts "enemy attack ranged #{enemy.attack_ranged}"
        #puts "my defense #{self.defense}"
        damage = enemy.attack_ranged - self.defense
        if damage <= 0
          damage = 1
        end

        #puts "My health #{self.temp_health}"
        self.temp_health = self.temp_health - damage
        puts "#{self.name} took #{damage} damage!"
      else
        puts "Your opponent missed!"
      end

    when "melee"
      if Robot.is_hit(self.melee_evade) == true
        #puts "enemy attack ranged #{enemy.attack_melee}"
        #puts "my defense #{self.defense}"
        damage = enemy.attack_melee - self.defense
        if damage <= 0
          damage = 1
        end
        #puts "My health #{self.temp_health}"
        self.temp_health = self.temp_health - damage
        puts "#{self.name} took #{damage} damage!"

      else
        puts "Your opponent missed!"
      end

    else
      #can't happen.
    end
#----End of opponent's attack----

  puts "Your Health is now #{self.temp_health}."
  puts "Your Opponent's health is now #{enemy.temp_health}."

  if self.temp_health <= 0 && enemy.temp_health <= 0
    puts "It's a tie!"
  elsif self.temp_health <= 0
    puts "You lost..."
  elsif enemy.temp_health <= 0
    puts "You won!"
  else
    battle_loop(enemy)
  end
end


  #I calculate result to stats to each bot

  #instance methods can only be called by instances of a class



  def choose_attack_random
    basic = ["ranged", "melee"]
    full_list = basic
    return full_list.sample
  end


  def choose_attack
    basic = ["ranged", "melee"]
    full_list = basic
    puts "Please choose from one of the following attacks for #{name}:"
    #Robot.print_array(full_list)
    choice = Robot.choose(full_list)
    return choice
  end



  def ranged_evade

    if self.flight == true
      return ranged_evasion + level * 2
    else
      return ranged_evasion + level
    end
  end

  def melee_evade
    if self.flight == true
      return melee_evasion + level * 2
    else
      return melee_evasion + level
    end
  end

  def self.is_hit(number)
    puts number
    range = rand(99) + 1
    puts range
    if range > number
      return true
    else
      return false
    end
  end




#END BATTLE
#------------------------

  def describe(model)
    case model
    when "MTB"
      return "The MTB Model is a moderately sturdy BattleBot that specializes in ranged combat
        While it's melee attacks are strong (melee attacks tend to be stronger than ranged),
        it has the potential to dish out massive damage with the right ranged weapon.
        Ranged attacks are versitile and is able to hit any type of enemy easily.
        MTBs are especially strong against SMD bots as it renders their biggest strength,
        high evasion against melee, useless."
    when "RKS"
      return "The RKS Model is very strudy (high in defense), this BattleBot specializes
        in dishing out TONS of damange with Melee attacks, but strugges against flyers as
        their ranged attacks are usually quite weak. However, it is very strudy second
        only to the TLZ."
    when "TLZ"
      return "The great TLZ is the tank of the BattleBot world. It has the highest defense
      amongst all its peers. However, its attack is relatively low. It has a high health pool
        so it is very good in a battle of attrition such as with the NTN"
    when "SMD"
      return "The SMD is the agile flyer. It is the only BattleBot with the flight ability
        which gives it a very high evasion against ranged attacks, and just high evastion
        in general. Its attacks are pretty average but it's a bit fragile when you actually
        manage to hit it. It also has relatively more sprit power so it can use more
        special moves."
    when "NTN"
      return "The NTN is the spirtual healer. In fact, it has no attacks! Its battle
        plan is very much different from that of other BattleBots. 'Sprit Wave',
        the ability exclusive to the NTN models will deactivate your opponent's
        BattleBot when it is at full charge, the NTN will have access to a variety of
        abilities to stay alive until Sprit Wave's charge is full. NTN also has
        more spirt power than all other bots so it can use various abilities to
        help it stay alive that the other bots probably can't afford to do."
    else
    end
  end

  def self.random_robot_maker(name)
    possible_models = ["MTB", "RKS", "TLZ", "SMD", "NTN"]
    Robot.new(name, possible_models.sample)
  end

  def self.match_bot_id(array_of_bots)
    the_hash = {}
    array_of_bots.each do |bot|
      the_hash[bot.object_id.to_s] = bot
    end
    return the_hash
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



#Support methods

  def self.print_array(array)
    array.each do |item|
      puts ">> #{item}"
    end
  end

  def self.choose (array, case_sensitive = "no")

    Robot.print_array(array)
    array_downcase = array.map{|x| x.downcase}

    if case_sensitive == "no"
      choice = gets.strip.downcase
      if array_downcase.include?(choice)
        return choice
      else
        puts "sorry, this input is invalid, please choose from the available choices"
        Robot.choose(array)
      end
    else
      choice = gets.strip
      if array.include?(choice)
        return choice
      else
        puts "sorry, this input is invalid, please choose from the available choices (remember it's case sensitive!)"
        Robot.choose(array, "yes")
      end
    end


  end

  def self.press_key
    puts "Press any key to continue".yellow
    gets
    puts "---------------------------------------".yellow
    puts ""
  end

  def self.select_a_robot(list_of_bots)
    my_choices = Robot.match_bot_id(list_of_bots)
    choice = Robot.choose(my_choices.keys)
    

  end
end




#-----------
#outside of class
#------------- main menu--------------
def main_menu(saved_file = "none")
  if saved_file == "none"
    puts "You have no existing BattleBots on file, try creating a new BattleBot!"
    mybots = [] #array of objects.
  else
    mybots = saved_file
    puts "You have #{mybots.length} BattleBots!"

    mybots.each do |bot|
      puts "=> #{bot.name}: Level #{bot.level}, #{bot.type}"
    end
  end

  puts "Please select an option".yellow
  option = Robot.choose(["Create new BattleBot", "Create Random BattleBot", "View my BattleBots", "Battle Random BattleBot", "Save my progress", "Exit"])

  #binding.pry
  case option
  when "create new battlebot"
    name = Robot.get_name
    model = Robot.choose(["MTB", "RKS", "TLZ", "SMD", "NTN"], "yes")
    puts "Please choose from one of the following types of BattleBots:"
    bot = Robot.new(name, model)
    puts "You created a new #{bot.type} BattleBot #{bot.name}!".green
    bot.display_stats
    mybots.push(bot)
    Robot.press_key
    main_menu(mybots)

  when "create random battlebot"
    name = Robot.get_name
    bot = Robot.random_robot_maker(name)
    puts "You created a new #{bot.type} BattleBot #{bot.name}!".green
    bot.display_stats
    mybots.push(bot)
    Robot.press_key
    main_menu(mybots)

  when "view my battlebots"
    puts "You have #{mybots.length} BattleBots!"
    list_of_bots = ""
    mybots.each do |bot|
      puts "=> #{bot.name}: Level #{bot.level}, #{bot.type}"
      bot.
    end



    main_menu(mybots)

  when "battle random battlebot"

    bot.battle_random_bot

  when "save my progress"
    puts "Saving your progress..."
    convert_to_file(mybots)
    puts "Finished saving your progress!"
    main_menu(mybots)

  when "exit"
    puts "Bye!".green
  end

end



def convert_to_file(array)
  master_string = ""
  array.each do |bot| #we expect each bot to be an Robot object

    #master_string << "{"

    master_string << "name:"
    master_string << bot.name
    master_string << ","

    master_string << "type:"
    master_string << bot.type
    master_string << ","

    master_string << "level:"
    master_string << bot.level.to_s
    master_string << ","

    master_string << "experience:"
    master_string << bot.experience.to_s
    master_string << ","

    master_string << "attack_ranged:"
    master_string << bot.attack_ranged.to_s
    master_string << ","

    master_string << "defense:"
    master_string << bot.defense.to_s
    master_string << ","

    master_string << "flight:"
    if bot.flight == true
      master_string << "true"
    else
      master_string << "false"
    end
    master_string << ","

    master_string << "sprit_power:"
    master_string << bot.sprit_power.to_s
    master_string << ","

    master_string << "max_health:"
    master_string << bot.max_health.to_s
    master_string << ","

    master_string << "ranged_evasion:"
    master_string << bot.ranged_evasion.to_s
    master_string << ","

    master_string << "melee_evasion:"
    master_string << bot.melee_evasion.to_s

    master_string << "}"
  end


  puts master_string
  fh = File.new("data/robot_data", "w")
  fh.puts master_string
  fh.close
end

def read_from_file
  file_info = File.read("data/robot_data").strip

  bot_list = file_info.split("}")

  #Look at each bot, job here is to create a bot.
  mybots = []

  bot_list.each do |bot| #each bot.
    bot_hash = {}
    attribute_list = bot.split(",")

    attribute_list.each do |attribute|
      value_pair = attribute.split(":")
      bot_hash[value_pair[0]] = value_pair[1]
    end
    temp_bot = Robot.new(bot_hash["name"], bot_hash["type"], bot_hash)
    mybots.push(temp_bot)
  end

  return mybots

end




#if File.readable?("users/#{code}")
  #user_info = File.read("users/#{code}").strip



#program starts
if File.readable?("data/robot_data")
  main_menu(read_from_file)
else
  main_menu("none")
end
