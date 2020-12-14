
require 'colorize'
require_relative 'validators'

module General

  PI = 3.14

  def self.general_calculations()
    system("clear")

    puts "\n##### GENERAL CALCULATIONS #####".colorize(:light_yellow)
    puts "\nWelcome to General Calculations!"
    puts "\nWhat would you like to calculate?"
    puts "\n1. Speed of Sound".colorize(:light_green)
    puts "2. Exit".colorize(:light_green)
    input = gets.chomp.to_i
    valid_input = Validators.validate_input(input)
    case input 
    when 1
      speed_of_sound()
    when 2
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    else
      puts "\nInvalid input!".colorize(:red)
      puts "Only values between 1-2 are accepted"
      puts "Hit Enter to continue"
      gets
      general_calculations()
    end
  end

  def self.speed_of_sound()
    puts "\n# SPEED OF SOUND #".colorize(:light_yellow)
    puts "\nPlease input the temperature (Celsius): ".colorize(:light_green)
    temperature = gets.chomp.to_f

    speed = (331.3 * Math.sqrt(1 + (temperature / 273.15))).truncate(0)
    puts "\nThe speed of sound is #{speed} m/s."

    while true
      puts "\nWould you like to try again? (y/n)".colorize(:light_green)
      choice = gets.chomp
      case choice
      when'y'
        speed_of_sound()
      when 'n'
        puts "\nSee you later!".colorize(:light_yellow)
        exit!
      else
        puts "\nInvalid input!".colorize(:red)
        puts "Only (y/n) are accepted."
        puts "Press any key and hit Enter to continue."
        gets
      end
    end 
  end

end

