
require 'tty-box'
require_relative 'coefficients'

module ReverbTime

  include Coeffs

  def self.sabine(volume, total_absorption)
    rt_sabine = (0.16 * volume) / total_absorption
    return "The Sabine reverberation time is %0.2f seconds.".colorize(:light_yellow) % [rt_sabine]
  end
  
  def self.eyring(volume, total_surface, avg_abs_coeff)
    rt_eyring = (0.16 * volume) / (-2.3 * total_surface * Math.log10(1 - avg_abs_coeff))
    return "The Norris-Eyring reverberation time is %0.2f seconds.".colorize(:light_yellow) % [rt_eyring]
  end

  def self.another_calc?()
    puts "\nWould you like to make another RT calculation? (y/n)"
    try_again = gets.chomp
    case try_again 
    when 'y'
      menu()
    when 'n'
      back_to_intro?()
    else
      puts "\nInvalid input! Only (y/n) are accepted.".colorize(:red)
      another_calc?()
    end
  end

  def self.back_to_welcome?()
    puts "\nWould you like to go back to the Welcome Menu? (y/n)"
    go_back = gets.chomp
    case go_back
    when 'y'
      begin
      intro()
      rescue ArgumentError 
        menu() # Forces it to go to Reverb Menu
      end
    when 'n'
      puts "\nSee you later!".colorize(:light_yellow)
    else
      puts "\nInvalid input! Only (y/n) are accepted.".colorize(:red)
      back_to_intro?()
    end  
  end


  ### Reverb Menu ###

  def self.menu()
    system ("clear")

    total_surface = 0
    volume = 0

    puts "\n##### REVERBERATION TIME CALCULATOR #####".colorize(:light_yellow)
    puts "\nWelcome to the RT calculator!"
    puts "\nThis calculator displays the RT values for both the Sabine and Norris-Eyring formulas."

    puts "\nBefore we proceed, I need to know some of the room properties."
    puts "What is the total surface area (m2)?"
    total_surface = gets.chomp.to_f

    puts "What is the volume (m3)?"
    volume = gets.chomp.to_f

    puts "\nFantastic! Now let's move on to the materials covering all the surfaces ".colorize(:light_yellow)
    puts "\nLet's begin with the floor.\n\n" 
    puts box = TTY::Box.frame(width: 25, height: 8, border: :thick, align: :center, padding: 2) do
      "Floor"
    end
    puts "\nPlease select one of the following materials: (1-5)"
    puts "\n1. Thin carpet on concrete".colorize(:light_green)
    puts "2. Thin carpet on wood".colorize(:light_green)
    puts "3. Wood on joists".colorize(:light_green)
    puts "4. Vinyl stuck to concrete".colorize(:light_green)
    puts "5. Rubber tiles".colorize(:light_green)
    floor_abs_coeffs = gets.chomp.to_i
    case floor_abs_coeffs
    when 1
      floor_abs_coeffs = thin_carpet_concrete
    when 2
      floor_abs_coeffs = thin_carpet_wood
    when 3 
      floor_abs_coeffs = wooden_floor_joists
    when 4
      floor_abs_coeffs = vinyl_stuck_concrete
    when 5
      floor_abs_coeffs = rubber_tiles
    else
    end

    puts "\nNow let's move on to the ceiling."
    puts box = TTY::Box.frame(width: 25, height: 8, border: :thick, align: :center, padding: 2) do
      "Ceiling"
    end
    puts "Please select one of the following materials: (1-5)"
    puts "\n1. Mineral wool tiles with 180mm of airspace".colorize(:light_green)
    puts "2. Gypsum plaster titles".colorize(:light_green)
    puts "3. Metal, 30% perforated, backed with 30mm rockwool".colorize(:light_green)
    puts "4. Decorative plaster tiles".colorize(:light_green)
    puts "5. 75mm Woodwool, backed with 25mm airgap".colorize(:light_green)
    ceiling_abs_coeffs = gets.chomp.to_i

    puts "\nFantastic! How about the walls?"
    puts "\nFront wall:"
    puts box = TTY::Box.frame(width: 10, height: 8, border: :thick, align: :center, padding: 2) do
      "Front wall"
    end
    puts "\n1. Rough concrete"
    puts "2. Smooth or painted concrete"
    puts "3. Standard brickwork"
    puts "4. Plasterboard"
    front_abs = gets.chomp.to_i

    puts "\nRight wall:"
    puts box = TTY::Box.frame(width: 25, height: 8, border: :thick, align: :center, padding: 2) do
      "Right wall"
    end
    puts "\n1. Rough concrete".colorize(:light_green)
    puts "2. Smooth or painted concrete".colorize(:light_green)
    puts "3. Standard brickwork".colorize(:light_green)
    puts "4. Plasterboard".colorize(:light_green)
    right_abs = gets.chomp.to_i

    puts "\nBack wall:"
    puts box = TTY::Box.frame(width: 10, height: 8, border: :thick, align: :center, padding: 2) do
      "Front wall"
    end
    puts "\n1. Rough concrete".colorize(:light_green)
    puts "2. Smooth or painted concrete".colorize(:light_green)
    puts "3. Standard brickwork".colorize(:light_green)
    puts "4. Plasterboard".colorize(:light_green)
    back_abs = gets.chomp.to_i

    puts "\nLeft wall:"
    puts box = TTY::Box.frame(width: 25, height: 8, border: :thick, align: :center, padding: 2) do
      "Left wall"
    end
    puts "\n1. Rough concrete".colorize(:light_green)
    puts "2. Smooth or painted concrete".colorize(:light_green)
    puts "3. Standard brickwork".colorize(:light_green)
    puts "4. Plasterboard".colorize(:light_green)
    left_abs = gets.chomp.to_i

    puts "\nAwesome! How about the door(s)?".colorize(:light_green)
    puts box = TTY::Box.frame(width: 5, height: 6, border: :thick, align: :center, padding: 2) do
      "Door(s)"
    end
    puts "\n1. Timber"
    puts "2. Wooden with a hollow core"
    door_abs = gets.chomp.to_i

    puts "\nHow about the window(s)?"
    puts box = TTY::Box.frame(width: 5, height: 4, border: :thick, align: :center, padding: 2) do
      "Window(s)"
    end
    puts "\n1. 4mm glass".colorize(:light_green)
    puts "2. 6mm glass".colorize(:light_green)
    window_abs = gets.chomp.to_i

    # puts "\nFinally, approximately how many people will occupy the room?"
    # people = gets.chomp.to_i


    ####################################

    

    puts "\nTotal absorption of the room (m2):".colorize(:light_green)
    total_absorption = gets.chomp.to_f

    puts "\nAverage Absorption Coefficient:".colorize(:light_green)
    avg_abs_coeff = gets.chomp.to_f
    puts 

    puts sabine(volume, total_absorption)
    puts eyring(volume, total_surface, avg_abs_coeff)

    another_calc?()
  end
end
