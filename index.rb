require 'colorize'
require_relative 'validators'
require_relative 'general-calculations'
require_relative 'sound-level'
require_relative 'reverb-time'

def intro()
  system("clear")

  include General
  include SoundLevel
  include ReverbTime
  
  puts "\nHello! Welcome to this simple room acoustics calculator.".colorize(:light_yellow)
  puts "\nWhat would you like to calculate? (Select 1-4)"
  puts "\n1. General Calculations".colorize(:light_green)
  puts "2. Sound Level".colorize(:light_green)
  puts "3. Reverberation Time (RT)".colorize(:light_green)
  puts "4. Exit".colorize(:light_green)
  
  input = gets.chomp.to_i
  valid_input = Validators.validate_input(input)
  case input
  when 1
    # General Calculations
    General.general_calculations()
  when 2
    # Sound level
    SoundLevel.level_calculations()
  when 3
    # Reverberation Time
    ReverbTime.reverb_calculations()
  when 4
    puts "\nSee you later!".colorize(:light_yellow)
    exit!
  else
    if !valid_input
      puts "\nInvalid input".colorize(:red)
      puts "Hit Enter to continue"
      gets
      intro()
    end
  end

end

intro()



