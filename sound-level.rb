require 'colorize'

puts "\n##### SOUND LEVEL CALCULATOR #####".colorize(:light_yellow)
puts "\nWelcome to the Sound Level calculator!"
puts "\nThis calculator displays the sum and the average of multiple sound pressure levels. (SPLs)"

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



