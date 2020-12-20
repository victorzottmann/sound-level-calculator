require 'colorize'
require 'tty-prompt'
require 'tty-box'
require_relative 'validators'

module SoundLevel

  PI = 3.14
  
  def self.level_calculations()
    system("clear")
    
    puts "\n================================================="
    puts "\n##### SOUND LEVEL CALCULATOR #####".colorize(:light_yellow)
    puts "\nWelcome to the Sound Level calculator!"
    
    prompt = TTY::Prompt.new

    options = [
      "A-Weighting Conversion",
      "Level Attenuation Over Distance", 
      "Level Conversion (Power to Pressure and Vice-Versa)", 
      "Sum and Average of Levels",
      "Exit"
    ]

    input = prompt.select("\nWhat would you like to calculate?\n", options)
    case input
    when "A-Weighting Conversion"
      a_weighting()

    when "Level Attenuation Over Distance"
      attenuation()

    when "Level Conversion (Power to Pressure and Vice-Versa)"
      level_conversion()

    when "Sum and Average of Levels"
      sum_and_average()

    when "Exit"
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    end   
  end 

  def self.a_weighting()
    system("clear")

    puts "\n================================================="
    puts "\n# A-Weighting Conversion #".colorize(:light_yellow)
    puts "\nThe conversion to the A-Weighted curve happens by subtracting (or adding) the following values from the given sound pressure levels:\n\n"

    puts "  63Hz   =>   -26.2".colorize(:cyan)
    puts " 125Hz   =>   -16.1".colorize(:cyan)
    puts " 250Hz   =>    -8.6".colorize(:cyan)
    puts " 500Hz   =>    -3.2".colorize(:cyan)
    puts "1000Hz   =>       0".colorize(:cyan) 
    puts "2000Hz   =>    +1.2".colorize(:cyan) 
    puts "4000Hz   =>    +1.0".colorize(:cyan) 
    puts "8000Hz   =>    -1.1".colorize(:cyan)

    puts "\nPlease input sound levels for the following octave bands (63Hz - 8000Hz):\n\n"

    octave_levels = []

    print "63Hz: ".colorize(:green)
    first = gets.chomp.to_f
    print "125Hz: ".colorize(:green)
    second = gets.chomp.to_f
    print "250Hz: ".colorize(:green)
    third = gets.chomp.to_f
    print "500Hz: ".colorize(:green)
    fourth = gets.chomp.to_f
    print "1000Hz: ".colorize(:green)
    fifth = gets.chomp.to_f
    print "2000Hz: ".colorize(:green)
    sixth = gets.chomp.to_f
    print "4000Hz: ".colorize(:green)
    seventh = gets.chomp.to_f
    print "8000Hz: ".colorize(:green)
    eighth = gets.chomp.to_f
    
    octave_levels.push(first, second, third, fourth, fifth, sixth, seventh, eighth)
    a_weighting = [-26.2, -16.1, -8.6, -3.2, 0, 1.2, 1.0, -1.1]
    conversion = [octave_levels, a_weighting].transpose.map {|i| i.inject(:+)}
    
    puts "\nThe A-Weighted sound pressure levels are:\n\n"
    freq = 31.25
    conversion.each do |i|
      freq *= 2
      if freq == 62.5
        puts "#{freq.ceil}Hz = %0.1f dB(A)".colorize(:cyan) % [i]
      else
        puts "%.0fHz = %0.1f dB(A)".colorize(:cyan) % [freq, i]
      end
    end

    while true
      puts "\nWould you like to make another A-Weighting conversion? (y/n)"
      choice = gets.chomp
      case choice
      when 'y'
        a_weighting()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)"
        input = gets.chomp
        sound_level_menu(input)
      else
        Validators.invalid_yes_no()
      end
    end
  end

  def self.attenuation()
    system("clear")

    puts "\n================================================="
    puts "\n# LEVEL ATTENUATION OVER DISTANCE #".colorize(:light_yellow)
    puts "\nPlease input the Sound Pressure Level of the source:"
    source_level = gets.chomp.to_f
    
    puts "\nWhat is the distance (m) between the sound source and the receiver?"
    receiver_distance = gets.chomp.to_f
    source_distance = 1 
    
    receiver_level = 20 * Math.log10(receiver_distance / source_distance)
    level_difference = source_level - receiver_level
    
    puts "\nThe sound source will be reduced from #{source_level} dB to #{level_difference.truncate(1)} dB at #{receiver_distance} metres.".colorize(:cyan)
    
    puts "\nThis results in a level difference of #{receiver_level.truncate(1)} dB.".colorize(:cyan)
    
    while true
      puts "\nWould you like to try again? (y/n)"
      choice = gets.chomp
      case choice
      when 'y'
        attenuation()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)"
        input = gets.chomp
        sound_level_menu(input)
      else
        Validators.invalid_yes_no()
      end
    end
  end

  def self.level_conversion()
    system("clear")

    puts "\n================================================="
    puts "\n# LEVEL CONVERSION #".colorize(:light_yellow)

    prompt = TTY::Prompt.new

    options = [
      "Sound Power Level to Pressure Level", 
      "Sound Pressure Level to Power Level", 
      "Exit"
    ]

    input = prompt.select("\nWhat would you like to calculate?\n", options)
    case input
    when "Sound Power Level to Pressure Level"
      puts "\nPlease input the Sound Power Level:"
      power_level = gets.chomp.to_f  
      puts "\nWhat is the distance (m) between the sound source and the receiver?"
      distance = gets.chomp.to_f
      puts power_to_pressure_level(power_level, distance).colorize(:cyan)

    when "Sound Pressure Level to Power Level"
      puts "\nPlease input the Sound Pressure Level:"
      pressure_level = gets.chomp.to_f
      puts "\nWhat is the distance (m) between the sound source and the receiver?"
      distance = gets.chomp.to_f
      puts pressure_to_power_level(pressure_level, distance).colorize(:cyan)

    when "Exit"
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    end

    while true
      puts "\nWould you like to try again? (y/n)"
      choice = gets.chomp
      case choice
      when'y'
        level_conversion()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)"
        input = gets.chomp
        sound_level_menu(input)
      else
        Validators.invalid_yes_no
      end
    end
  end

  def self.sum_and_average()
    system("clear")
    
    puts "\n================================================="
    puts "\n# Sum and Average Calculator #".colorize(:light_yellow)
    puts "\nPlease input an array of sound pressure levels (SPL) separated by a space:"
    
    input = gets.chomp.split(" ")
    input = input.map(&:to_f)
    
    # Sum of levels
    total_sum = 0
    
    level_sum = input.map {|i| 10 ** (i / 10)}
    level_sum.each {|i| total_sum += i}
    
    # Average of levels
    total_avg = 0
    total_indices = input.length
    
    level_avg = input.map {|j| (10 ** (j / 10)) / (total_indices)}
    level_avg.each {|j| total_avg += j}
    
    puts "\nThe SPL sum is equal to %.1f dB".colorize(:cyan) % [10*Math.log10(total_sum)]
    puts "The average SPL is equal to %.1f dB".colorize(:cyan) % [10*Math.log10(total_avg)] 

    while true
      puts "\nWould you like to make another Sum and Average calculation? (y/n)"
      choice = gets.chomp
      case choice
      when 'y'
        sum_and_average()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)"
        go_back = gets.chomp
        sound_level_menu(go_back)
      else
        Validators.invalid_yes_no()
      end
    end
  end

  def self.power_to_pressure_level(power_level, distance)
    pressure_level = power_level + (10 * Math.log10(1 / (4 * PI * (distance * distance))))

    output = "\nThe resulting Sound Pressure Level is %.1f dB." % [pressure_level]
    return output
  end

  def self.pressure_to_power_level(pressure_level, distance)
    power_level = (pressure_level - (10 * Math.log10(1 / (4 * PI * (distance * distance)))))

    output = "\nThe resulting Sound Power Level is %.1f dB." % [power_level]
    return output
  end

  def sound_level_menu(input)
    case input
    when 'y'
      level_calculations()
    when 'n'
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    else
      Validators.invalid_yes_no()
    end
  end

end

