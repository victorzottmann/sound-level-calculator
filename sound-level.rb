require 'colorize'

module SoundLevel
  def menu()
    system("clear")
  
    puts "\n##### SOUND LEVEL CALCULATOR #####".colorize(:light_yellow)
    puts "\nWelcome to the Sound Level calculator!"
    puts "\nThis calculator displays the sum and the average of multiple sound pressure levels. (SPLs)"
    puts "Please select one of the following options:"
    puts "1. Sum and Average of Sound Pressure Levels"
    puts "2. A-Weighting Conversion"
    options = gets.chomp.to_i
    case choice
    when 1
      puts "Sum and Average Calculator"
      puts "\nPlease input an array of SPLs separated by a space".colorize(:green)
      
      input = gets.chomp.split(" ")
      input = input.map(&:to_f)
      
      # Sum of levels
      total_sum = 0
      
      level_sum = input.map {|i| 10**(i/10)}
      level_sum.each {|i| total_sum += i}
      
      # Average of levels
      total_avg = 0
      total_indices = input.length
      
      level_avg = input.map {|j| (10**(j/10))/(total_indices)}
      level_avg.each {|j| total_avg += j}
      
      puts "\nThe SPL sum is equal to %.1f dB".colorize(:light_yellow) % [10*Math.log10(total_sum)]
      puts "The average SPL is equal to %.1f dB".colorize(:light_yellow) % [10*Math.log10(total_avg)]
    when 2
      puts "\nA-Weighting Conversion".colorize(:light_yellow)
      puts "\nPlease input levels for the following octave bands:"

      octave_levels = []

      print "125Hz: ".colorize(:light_green)
      first = gets.chomp.to_f
      print "250Hz: ".colorize(:light_green)
      second = gets.chomp.to_f
      print "500Hz: ".colorize(:light_green)
      third = gets.chomp.to_f
      print "1000Hz: ".colorize(:light_green)
      fourth = gets.chomp.to_f
      print "2000Hz: ".colorize(:light_green)
      fifth = gets.chomp.to_f
      print "4000Hz: ".colorize(:light_green)
      sixth = gets.chomp.to_f
      
      octave_levels.push(first, second, third, fourth, fifth, sixth)
      a_weighting = [-16.1, -8.6, -3.2, 0, 1.2, 1.0, -1.1]
      conversion = [octave_levels, a_weighting].transpose.map {|i| i.inject(:+)}
      
      puts "\nThe A-Weighted sound pressure levels are:\n\n"
      freq = 62.5
      conversion.each do |i|
        freq *= 2
        puts "%.0fHz = %0.1f dB(A)".colorize(:cyan) % [freq, i]
      end
    else
    end   
  end 
end





