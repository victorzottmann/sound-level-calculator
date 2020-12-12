require 'colorize'
require_relative 'validators'
require_relative 'distance'
require_relative 'sound-level'
require_relative 'reverb-time'

def intro()
  system("clear")

  include SourceDistance
  include SoundLevel
  include ReverbTime
  
  puts "\nHello! Welcome to this simple room acoustics calculator.".colorize(:light_yellow)
  puts "\nWhat would you like to calculate? (Select 1-4)"
  puts "\n1. Level Attenuation Over Distance".colorize(:light_green)
  puts "2. Sound Pressure Level".colorize(:light_green)
  puts "3. Reverberation Time (RT)".colorize(:light_green)
  puts "4. Exit".colorize(:light_green)
  
  input = gets.chomp.to_i
  valid_input = Validators.validate_input(input)
  case input
  when 1
    # Distance
    SourceDistance.distance_calculation()
  when 2
    # Sound level
    SoundLevel.level_calculation()
  when 3
    # Reverberation Time
    ReverbTime.reverb_calculation()
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



