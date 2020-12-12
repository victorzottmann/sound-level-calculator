require 'colorize'
require_relative 'validators'
require_relative 'sound-level'
require_relative 'reverb-time'


def intro()
  system("clear")

  include SoundLevel
  include ReverbTime
  
  puts "\nHello! Welcome to this simple room acoustics calculator.".colorize(:light_yellow)
  puts "\nWhat would you like to calculate? (Select 1-4)"
  puts "\n1. Sound Pressure Level".colorize(:light_green)
  puts "2. Reverberation Time (RT)".colorize(:light_green)
  puts "3. Transmission Loss".colorize(:light_green)
  puts "4. Exit".colorize(:light_green)
  
  input = gets.chomp.to_i
  valid_input = Validators.validate_input(input)
  case input
  when 1
    # Sound level
    SoundLevel.level_calculation()
  when 2
    # Reverberation Time
    ReverbTime.menu()
  when 3
    # Need something
  when 4
    puts "See you later!"
    exit!
  else
    if !valid_input
      puts "\nInvalid input".colorize(:red)
      puts "Type any key to continue"
      gets
      intro()
    end
  end

end

intro()



