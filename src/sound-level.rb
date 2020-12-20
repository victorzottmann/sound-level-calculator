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
    proceed = false

    # The following while loops are very repetitive and do not follow the DRY (Don't Repeat Yourself) approach. These were last-minute bug fixes, so I could not think quickly of a better way to simplify everything. 
    
    # The problem here is that the variable changes for every input. (i.e. first, second, third, etc.)
    while !proceed
      print "63Hz: ".colorize(:green)
      first = gets.chomp.to_f
      valid_level = Validators.validate_level(first)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      print "125Hz: ".colorize(:green)
      second = gets.chomp.to_f
      valid_level = Validators.validate_level(second)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      print "250Hz: ".colorize(:green)
      third = gets.chomp.to_f
      valid_level = Validators.validate_level(third)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      print "500Hz: ".colorize(:green)
      fourth = gets.chomp.to_f
      valid_level = Validators.validate_level(fourth)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      print "1000Hz: ".colorize(:green)
      fifth = gets.chomp.to_f
      valid_level = Validators.validate_level(fifth)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      print "2000Hz: ".colorize(:green)
      sixth = gets.chomp.to_f
      valid_level = Validators.validate_level(sixth)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      print "4000Hz: ".colorize(:green)
      seventh = gets.chomp.to_f
      valid_level = Validators.validate_level(seventh)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      print "8000Hz: ".colorize(:green)
      eighth = gets.chomp.to_f
      valid_level = Validators.validate_level(eighth)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

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

    puts "\n============================="

    while true
      puts "\nWould you like to make another A-Weighting conversion? (y/n)".colorize(:green)
      choice = gets.chomp
      case choice
      when 'y'
        a_weighting()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)".colorize(:green)
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

    proceed = false
    while !proceed
      puts "\nPlease input the Sound Pressure Level of the source:".colorize(:green)
      source_level = gets.chomp.to_f
      valid_level = Validators.validate_level(source_level)
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end
    
    while !proceed
      puts "\nWhat is the distance (m) between the sound source and the receiver?".colorize(:green)
      receiver_distance = gets.chomp.to_f
      valid_receiver_distance = Validators.validate_distance(receiver_distance)
      if !valid_receiver_distance
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    source_distance = 1 
    
    receiver_level = 20 * Math.log10(receiver_distance / source_distance)
    level_difference = source_level - receiver_level
    
    puts "\nThe sound source will be reduced from #{source_level} dB to #{level_difference.truncate(1)} dB at #{receiver_distance} metres.".colorize(:cyan)
    
    puts "\nThis results in a level difference of #{receiver_level.truncate(1)} dB.".colorize(:cyan)

    puts "\n============================="
    
    while true
      puts "\nWould you like to try again? (y/n)".colorize(:green)
      choice = gets.chomp
      case choice
      when 'y'
        attenuation()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)".colorize(:green)
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
      puts power_to_pressure_level().colorize(:cyan)

    when "Sound Pressure Level to Power Level"
      puts pressure_to_power_level().colorize(:cyan)

    when "Exit"
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    end

    puts "\n============================="

    while true
      puts "\nWould you like to try again? (y/n)".colorize(:green)
      choice = gets.chomp
      case choice
      when'y'
        level_conversion()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)".colorize(:green)
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

    proceed = false
    while !proceed
      puts "\nPlease input an array of sound pressure levels (SPL) separated by a space:".colorize(:green)
      levels = gets.chomp.split(" ")
      levels = levels.map {|i| i.to_f}
      valid_levels = Validators.validate_pressure_levels(levels)
      if !valid_levels
        Validators.invalid_number_error
        !proceed
      else
        break
      end
    end
    
    # Sum of levels
    total_sum = 0
    
    level_sum = levels.map {|i| 10 ** (i / 10)}
    level_sum.each {|i| total_sum += i}
    
    # Average of levels
    total_avg = 0
    total_indices = levels.length
    
    level_avg = levels.map {|j| (10 ** (j / 10)) / (total_indices)}
    level_avg.each {|j| total_avg += j}
    
    puts "\nThe SPL sum is equal to %.1f dB".colorize(:cyan) % [10*Math.log10(total_sum)]
    puts "The average SPL is equal to %.1f dB".colorize(:cyan) % [10*Math.log10(total_avg)] 

    puts "\n============================="

    while true
      puts "\nWould you like to make another Sum and Average calculation? (y/n)".colorize(:green)
      choice = gets.chomp
      case choice
      when 'y'
        sum_and_average()
      when 'n'
        puts "\nWould you like to go back to the Sound Level menu? (y/n)".colorize(:green)
        go_back = gets.chomp
        sound_level_menu(go_back)
      else
        Validators.invalid_yes_no()
      end
    end
  end

  def self.power_to_pressure_level()
    proceed = false
    while !proceed
      puts "\nPlease input the Sound Power Level:".colorize(:green)
      power_level = gets.chomp.to_f 
      valid_level = Validators.validate_level(power_level) 
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      puts "\nWhat is the distance (m) between the sound source and the receiver?".colorize(:green)
      distance = gets.chomp.to_f
      valid_distance = Validators.validate_distance(distance)
      if !valid_distance
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    pressure_level = power_level + (10 * Math.log10(1 / (4 * PI * (distance * distance))))

    output = "\nThe resulting Sound Pressure Level is %.1f dB." % [pressure_level]
    return output
  end

  def self.pressure_to_power_level()
    proceed = false
    while !proceed
      puts "\nPlease input the Sound Pressure Level:".colorize(:green)
      pressure_level = gets.chomp.to_f 
      valid_level = Validators.validate_level(pressure_level) 
      if !valid_level
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

    while !proceed
      puts "\nWhat is the distance (m) between the sound source and the receiver?".colorize(:green)
      distance = gets.chomp.to_f
      valid_distance = Validators.validate_distance(distance)
      if !valid_distance
        Validators.invalid_number_error()
        !proceed
      else
        break
      end
    end

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

