
module General

  PI = 3.14

  def self.general_calculations()
    system("clear")
    
    puts "\n##### GENERAL CALCULATIONS #####".colorize(:light_yellow)
    puts "\nWelcome to the Sound Level calculator!"
    choice = gets.chomp.to_i
    case choice 
    when 1
      attenuation()
    when 2
      speed_of_sound()
    else
      puts "\nInvalid input!".colorize(:red)
      puts "Only values between 1-5 are accepted"
      puts "Hit Enter to continue"
      gets
      general_calculations()
    end
  end

  def self.attenuation()
    source_level = 85
    
    source_distance = 1 # metres
    receiver_distance = 1.2 # metres
    
    receiver_level = 20 * Math.log10(receiver_distance / source_distance)
    
    level_difference = source_level - receiver_level
    
    puts "\nThe sound source will be reduced from #{source_level} dB to #{level_difference.truncate(1)} dB at #{receiver_distance} metres."
    
    puts "\nThis results in a level difference of #{receiver_level.truncate(1)} dB."
  end

  def self.speed_of_sound(temperature)
    speed = (331.3 * Math.sqrt(1 + (temperature / 273.15))).truncate(0)
    return speed
  end

  def self.power_to_pressure_levels()
    distance = 1
    power_level = 70

    pressure_level = (power_level + (10 * Math.log10(1 / (4 * PI * (distance * distance))))).truncate(1)
  end

  def self.pressure_to_power_levels()
    distance = 1
    pressure_level = 59

    power_level = (pressure_level - (10 * Math.log10(1 / (4 * PI * (distance * distance))))).truncate(1)
  end
  
end

