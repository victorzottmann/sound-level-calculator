require 'colorize'

module SoundLevel

  PI = 3.14

  def self.level_calculations()
    system("clear")
  
    puts "\n##### SOUND LEVEL CALCULATOR #####".colorize(:light_yellow)
    puts "\nWelcome to the Sound Level calculator!"
    puts "\nThis calculator displays the sum and the average of unlimited sound pressure levels."
    puts "\nYou can also convert levels within 1/1 octave bands (63Hz - 8000Hz) into A-Weighted values."
    puts "\nPlease select one of the following options:"
    puts "\n1. Level Attenuation Over Distance".colorize(:light_green)
    puts "2. Level Conversion (Power to Pressure and Vice-Versa)".colorize(:light_green)
    puts "3. Sum and Average of Levels".colorize(:light_green)
    puts "4. A-Weighting Conversion".colorize(:light_green)
    puts "5. Exit".colorize(:light_green)
    choice = gets.chomp.to_i
    case choice
    when 1
      attenuation()
    when 2
      level_conversion()
    when 3
      sum_and_average()
    when 4
      a_weighting()
    when 5
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    else
      puts "Invalid input!".colorize(:red)
      puts "Only values between 1-3 are accepted."
      puts "Press any key to continue."
      gets
      level_calculation()  
    end   
  end 

  def self.attenuation()
    
    puts "\n# LEVEL ATTENUATION OVER DISTANCE #".colorize(:light_yellow)
    puts "\nPlease input the Sound Pressure Level of the source:".colorize(:light_green)
    source_level = gets.chomp.to_f
    
    puts "\nWhat is the distance (m) between the sound source and the receiver?".colorize(:light_green)
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
        exit!
      else
        yn_invalid()
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
      puts "\nWhat is the Sound Power Level?"
      power_level = gets.chomp.to_f  
      puts "\nWhat is the distance (m) between the sound source and the receiver?"
      distance = gets.chomp.to_f
      puts power_to_pressure_level(power_level, distance).colorize(:cyan)
    when 2
      puts "\nWhat is the Sound Pressure Level?"
      pressure_level = gets.chomp.to_f
      puts "\nWhat is the distance (m) between the sound source and the receiver?"
      distance = gets.chomp.to_f
      puts pressure_to_power_level(pressure_level, distance).colorize(:cyan)
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
      puts "\nWould you like to try again? (y/n)"
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

  def self.sum_and_average()
    puts "\nSum and Average Calculator".colorize(:light_yellow)
    puts "\nPlease input an array of sound pressure levels (SPL) separated by a comma".colorize(:light_green)
    
    input = gets.chomp.split(",")
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
    
    puts "\nThe SPL sum is equal to %.1f dB".colorize(:light_yellow) % [10*Math.log10(total_sum)]
    puts "The average SPL is equal to %.1f dB".colorize(:light_yellow) % [10*Math.log10(total_avg)] 
  end

  def self.a_weighting()
    puts "\nA-Weighting Conversion".colorize(:light_yellow)
    puts "\nPlease input sound levels for the following octave bands (63Hz - 8000Hz):\n\n"

    octave_levels = []

    print "63Hz: ".colorize(:light_green)
    first = gets.chomp.to_f
    print "125Hz: ".colorize(:light_green)
    second = gets.chomp.to_f
    print "250Hz: ".colorize(:light_green)
    third = gets.chomp.to_f
    print "500Hz: ".colorize(:light_green)
    fourth = gets.chomp.to_f
    print "1000Hz: ".colorize(:light_green)
    fifth = gets.chomp.to_f
    print "2000Hz: ".colorize(:light_green)
    sixth = gets.chomp.to_f
    print "4000Hz: ".colorize(:light_green)
    seventh = gets.chomp.to_f
    print "8000Hz: ".colorize(:light_green)
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
        go_back = gets.chomp
        case go_back
        when 'y'
          level_calculations()
        when 'n'
          puts "\nSee you later!".colorize(:light_yellow)
          exit!
        else
          yn_invalid()
        end
      else
        yn_invalid()
      end
    end
  end

  def yn_invalid()
    puts "\nInvalid input!".colorize(:red)
    puts "Only (y/n) are accepted"
    puts "Press any key to continue"
    gets
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

