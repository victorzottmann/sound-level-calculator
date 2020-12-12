require 'colorize'
require_relative 'validators'
require_relative 'reverb-time'

def intro()
  system("clear")

  include ReverbTime
  
  
  puts "\nHello! Welcome to this simple room acoustics calculator."
  puts "\nWhat would you like to calculate? (Select 1-4)"
  puts "\n1. Sound Pressure Level".colorize(:light_green)
  puts "2. Reverberation Time (RT)".colorize(:light_green)
  puts "3. Absorption".colorize(:light_green)
  puts "4. Transmission Loss".colorize(:light_green)
  
  input = gets.chomp.to_i
  valid_input = Validators.validate_input(input)
  
  case input
  when 1
    # Sound level
  when 2
    # Reverb Time
    ReverbTime.rt_menu()
  when 3
    # Absorption
  when 4
    # Transmission loss
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



