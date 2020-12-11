
module ReverbTime
  def menu()
    system ("clear")

    puts "\n##### REVERBERATION TIME CALCULATOR #####".colorize(:light_yellow)
    puts "\nWelcome to the RT calculator!"
    puts "\nThis calculator displays the RT values for both the Sabine and Norris-Eyring formulas."
    puts "\nPlease input the following parameters:".colorize(:light_yellow)

    puts "\nVolume of the room (m3):".colorize(:light_green)
    volume = gets.chomp.to_f
    puts "\nTotal absorption of the room (m2):".colorize(:light_green)
    total_absorption = gets.chomp.to_f
    puts "\nTotal surface area of the room (m2):".colorize(:light_green)
    total_surface = gets.chomp.to_f
    puts "\nAverage Absorption Coefficient:".colorize(:light_green)
    avg_abs_coeff = gets.chomp.to_f
    puts 

    puts sabine(volume, total_absorption)
    puts eyring(volume, total_surface, avg_abs_coeff)

    puts "\nWould you like to try again? (y/n)".colorize(:light_green)
    input = gets.chomp
    if input == "n"
      puts "\nWould you like to go back to the Welcome Menu? (y/n)".colorize(:light_green)
      input = gets.chomp
      if input == "y"
        introduction()
      else
        puts "\nSee you later!".colorize(:light_yellow)
      end
    end
  end
  
  def sabine(volume, total_absorption)
    rt_sabine = (0.16 * volume) / total_absorption
    return "The Sabine reverberation time is %0.2f seconds.".colorize(:light_yellow) % [rt_sabine]
  end
  
  def eyring(volume, total_surface, avg_abs_coeff)
    rt_eyring = (0.16 * volume) / (-2.3 * total_surface * Math.log10(1 - avg_abs_coeff))
    return "The Norris-Eyring reverberation time is %0.2f seconds.".colorize(:light_yellow) % [rt_eyring]
  end
end
