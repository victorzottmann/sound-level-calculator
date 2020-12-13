
require 'colorize'
require_relative 'validators'

module General

  PI = 3.14

  def self.general_calculations()
    system("clear")

    puts "\n##### GENERAL CALCULATIONS #####".colorize(:light_yellow)
    puts "\nWelcome to General Calculations!"
    puts "\nWhat would you like to calculate?"
    puts "\n1. Level Attenuation Over Distance".colorize(:light_green)
    puts "2. Level Conversion (Power to Pressure and Vice-Versa)".colorize(:light_green)
    puts "3. Speed of Sound".colorize(:light_green)
    puts "4. Exit".colorize(:light_green)
    input = gets.chomp.to_i
    valid_input = Validators.validate_input(input)
    case input 
    when 1
      attenuation()
    when 2
      level_conversion()
    when 3
      speed_of_sound()
    when 4
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    else
      puts "\nInvalid input!".colorize(:red)
      puts "Only values between 1-5 are accepted"
      puts "Hit Enter to continue"
      gets
      general_calculations()
    end
  end

  def self.attenuation()
    
    puts "\n# LEVEL ATTENUATION OVER DISTANCE #".colorize(:light_yellow)
    puts "\nPlease input the Sound Pressure Level of the source:".colorize(:light_green)
    source_level = gets.chomp.to_f
    
    puts "\nWhat is the distance (m) of the receiver?".colorize(:light_green)
    receiver_distance = gets.chomp.to_f
    source_distance = 1 
    
    receiver_level = 20 * Math.log10(receiver_distance / source_distance)
    level_difference = source_level - receiver_level
    
    puts "\nThe sound source will be reduced from #{source_level} dB to #{level_difference.truncate(1)} dB at #{receiver_distance} metres."
    
    puts "\nThis results in a level difference of #{receiver_level.truncate(1)} dB."
    
    while true
      puts "\nWould you like to try again? (y/n)".colorize(:light_green)
      choice = gets.chomp
      case choice
      when 'y'
        attenuation()
      when 'n'
        puts "\nSee you later!".colorize(:light_yellow)
        break
      else
        puts "\nInvalid input!".colorize(:red)
        puts "Only (y/n) are accepted."
        puts "Press any key and hit Enter to continue."
        gets
      end
    end
  end

  def self.level_conversion()
    puts "\n# LEVEL CONVERSION #".colorize(:light_yellow)
    puts "\nWhat would you like to calculate? Select (1-2)"
    puts "\n1. Sound Power Level to Pressure Level".colorize(:light_green)
    puts "2. Sound Pressure Level to Power Level".colorize(:light_green)
    puts "3. Exit".colorize(:light_green)
    input = gets.chomp.to_i
    case input
    when 1
      puts "\nWhat is the Sound Power Level?".colorize(:light_green)
      power_level = gets.chomp.to_f  
      puts "\nWhat is the distance between the sound source and the receiver?"
      distance = gets.chomp.to_f
      puts power_to_pressure_level(power_level, distance)
    when 2
      puts "\nWhat is the Sound Pressure Level?".colorize(:light_green)
      pressure_level = gets.chomp.to_f
      puts "\nWhat is the distance between the sound source and the receiver?"
      distance = gets.chomp.to_f
      puts pressure_to_power_level(pressure_level, distance)
    when 3
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    else
      puts "Invalid input!".colorize(:red)
      puts "Only values between 1-2 are accepted."
      puts "Press any key and hit Enter to continue."
      gets
      level_conversion()
    end
    while true
      puts "\nWould you like to try again? (y/n)".colorize(:light_green)
      choice = gets.chomp
      case choice
      when'y'
        level_conversion()
      when 'n'
        puts "\nSee you later!".colorize(:light_yellow)
        break
      else
        puts "\nInvalid input!".colorize(:red)
        puts "Only (y/n) are accepted."
        puts "Press any key and hit Enter to continue."
        gets
      end
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
    
  def self.power_to_pressure_level(power_level, distance)
    pressure_level = power_level + (10 * Math.log10(1 / (4 * PI * (distance * distance))))

    output = "\nThe resulting Sound Pressure Level is %.1f dB." % [pressure_level]
    return output
  end

  def self.pressure_to_power_level(pressure_level, distance)
    power_level = (pressure_level - (10 * Math.log10(1 / (4 * PI * (distance * distance))))).truncate(1)

    output = "\nThe resulting Sound Power Level is %.1f dB." % [power_level]
    return output
  end

end

