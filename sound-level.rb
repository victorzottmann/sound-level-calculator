require 'colorize'

module SoundLevel

  def self.level_calculation
    system("clear")

    # speech_level = {
    #   "125Hz": 49.9,
    #   "250Hz": 54.3,
    #   "500Hz": 58,
    #   "1000Hz": 52,
    #   "2000Hz": 44.8,
    #   "4000Hz": 38.8
    # }
    
    # speech_level.each_with_index do |(freq, level), i|
    #   puts "- #{freq}: #{level} dB".colorize(:cyan)
    # end
  
    puts "\n##### SOUND LEVEL CALCULATOR #####".colorize(:light_yellow)
    puts "\nWelcome to the Sound Level calculator!"
    puts "\nThis calculator displays the sum and the average of unlimited sound pressure levels."
    puts "\nYou can also convert levels within 1/1 octave bands (63Hz - 8000Hz) into A-Weighted values."
    puts "\nPlease select one of the following options:"
    puts "\n1. Sum and Average of Levels".colorize(:light_green)
    puts "2. A-Weighting Conversion".colorize(:light_green)
    puts "3. Exit".colorize(:light_green)
    choice = gets.chomp.to_i
    case choice
    when 1
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
    when 2
      puts "\nA-Weighting Conversion".colorize(:light_yellow)
      puts "\nPlease input levels for the following octave bands (63Hz - 8000Hz):\n\n"

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
        puts "\nWould you like to make another calculation? (y/n)"
        choice = gets.chomp
        if choice == 'y'
          level_calculation()
        elsif choice == 'n'
          puts "\nSee you later!".colorize(:light_yellow)
          break
          system("exit")
        else
          puts "\nInvalid input!".colorize(:red)
          puts "Only (y/n) are accepted"
          puts "Press any key to continue"
          gets
        end
      end
    when 3
      system("exit")
    else
      puts "Invalid input!".colorize(:red)
      puts "Only values between 1-3 are accepted."
      puts "Press any key to continue."
      gets
      level_calculation()  
    end   
  end 
end





