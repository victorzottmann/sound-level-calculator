
require 'colorize'
require 'tty-box'
require 'tty-prompt'
require_relative 'validators'
require_relative 'coefficients'

module ReverbTime

  def self.reverb_calculations()
    system ("clear")

    include Absorption

    prompt = TTY::Prompt.new

    floor_coeffs = {}
    ceiling_coeffs = {}
    front_wall_coeffs = {}
    back_wall_coeffs = {}
    left_wall_coeffs = {}
    right_wall_coeffs = {}
    door_coeffs = {}
    window_coeffs = {}

    floor_absorption = {}
    ceiling_absorption = {}
    front_wall_absorption = {}
    back_wall_absorption = {}
    left_wall_absorption = {}
    right_wall_absorption = {}
    door_absorption = {}
    window_absorption = {}

    total_surface_area = 0.0

    puts "\n================================================="
    puts "\n##### REVERBERATION TIME CALCULATOR #####".colorize(:light_yellow)
    puts "\nWelcome to the RT calculator!"
    puts "\nThis calculator displays the Reverberation Time given the dimensions and total absorption of the room.\n\n\n"

    important = TTY::Box.frame("It is assumed that the room is rectangular.", width: 30, height: 6, border: :thick, align: :center, padding: [1,0,0,1], title: {top_left: " IMPORTANT "}).colorize(:light_yellow)

    puts important

    puts "\nBefore we proceed, I need to know some of the properties of the room."
    puts "\nPlease input the following SURFACE AREAS (m2):\n\n"
    
    proceed = false

    while !proceed
      puts "Floor / Ceiling: ".colorize(:green)
      ceiling_surface_area = floor_surface_area = gets.chomp.to_f
      valid_area = Validators.validate_surface_area(floor_surface_area)
      if !valid_area
        invalid_input()
        !proceed
      else
        break
      end
    end

    while !proceed
      puts "\nFront / Back walls: ".colorize(:green)
      back_wall_surface_area = front_wall_surface_area = gets.chomp.to_f
      valid_area = Validators.validate_surface_area(front_wall_surface_area)
      if !valid_area
        invalid_input()
        !proceed
      else
        break
      end
    end

    while !proceed
      puts "\nLeft / Right walls: ".colorize(:green)
      right_wall_surface_area = left_wall_surface_area = gets.chomp.to_f
      valid_area = Validators.validate_surface_area(left_wall_surface_area)
      if !valid_area
        invalid_input()
        !proceed
      else
        break
      end
    end

    while !proceed
      puts "\nDoors: ".colorize(:green)
      door_surface_area = gets.chomp.to_f
      valid_area = Validators.validate_surface_area(door_surface_area)
      if !valid_area
        invalid_input()
        !proceed
      else
        break
      end
    end

    while !proceed
      puts "\nWindows: ".colorize(:green)
      window_surface_area = gets.chomp.to_f
      valid_area = Validators.validate_surface_area(window_surface_area)
      if !valid_area
        invalid_input()
        !proceed
      else
        break
      end
    end

    puts "\nWhat about the volume of the room (m3)?"

    while !proceed
      puts "\nVolume: ".colorize(:green)
      room_volume = gets.chomp.to_f
      valid_area = Validators.validate_surface_area(floor_surface_area)
      if !valid_area
        invalid_input()
        !proceed
      else
        break
      end
    end
   
    puts "\nFantastic! Now let's move on to the materials covering all the surfaces".colorize(:light_yellow)
    puts "\nPlease select one of the following materials (1-2), then hit Enter to continue:"

    while true
      puts "\nFloor:" 
      puts "\n1. Thin carpet on concrete".colorize(:green)
      puts "2. Wood on joists".colorize(:green)
      floor_type = gets.chomp.to_i
      case floor_type
      when 1
        Absorption::Coefficients.each do |item|
         if item[:material] == "thin_carpet_concrete"
          floor_coeffs = item[:coeffs]
         end
        end
        floor_coeffs.each do |frequency, coeff|
          floor_absorption[frequency] = (coeff * floor_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "wooden_floor_joists"
           floor_coeffs = item[:coeffs]
          end
         end
        floor_coeffs.each do |frequency, coeff|
          floor_absorption[frequency] = (coeff * floor_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end
  
    while true
    
      puts "\nCeiling:"
      puts "\n1. Mineral wool tiles with 180mm of airspace".colorize(:green)
      puts "2. Gypsum plaster titles".colorize(:green)
      ceiling_type = gets.chomp.to_i
      case ceiling_type
      when 1
        Absorption::Coefficients.each do |item|
          if item[:material] == "mineral_wool_tiles"
           ceiling_coeffs = item[:coeffs]
          end
         end
        ceiling_coeffs.each do |frequency, coeff|
          ceiling_absorption[frequency] = (coeff * ceiling_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "gypsum_plaster_tiles"
           ceiling_coeffs = item[:coeffs]
          end
         end
        ceiling_coeffs.each do |frequency, coeff|
          ceiling_absorption[frequency] = (coeff * ceiling_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end

    while true
      puts "\nFront wall:"
      puts "\n1. Brickwork".colorize(:green)
      puts "2. Plasterboard".colorize(:green)
      front_wall_type = gets.chomp.to_i
      case front_wall_type
      when 1
        Absorption::Coefficients.each do |item|
          if item[:material] == "brickwork"
           front_wall_coeffs = item[:coeffs]
          end
         end
        front_wall_coeffs.each do |frequency, coeff|
          front_wall_absorption[frequency] = (coeff * front_wall_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "plasterboard"
           front_wall_coeffs = item[:coeffs]
          end
         end
        front_wall_coeffs.each do |frequency, coeff|
          front_wall_absorption[frequency] = (coeff * front_wall_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end

    while true
      puts "\nBack wall:"
      puts "\n1. Brickwork".colorize(:green)
      puts "2. Plasterboard".colorize(:green)
      back_wall_type = gets.chomp.to_i
      case back_wall_type
      when 1
        Absorption::Coefficients.each do |item|
          if item[:material] == "brickwork"
           back_wall_coeffs = item[:coeffs]
          end
         end
        back_wall_coeffs.each do |frequency, coeff|
          back_wall_absorption[frequency] = (coeff * back_wall_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "plasterboard"
           back_wall_coeffs = item[:coeffs]
          end
         end
        back_wall_coeffs.each do |frequency, coeff|
          back_wall_absorption[frequency] = (coeff * back_wall_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end

    while true
      puts "\nLeft wall:"
      puts "\n1. Brickwork".colorize(:green)
      puts "2. Plasterboard".colorize(:green)
      left_wall_type = gets.chomp.to_i
      case left_wall_type
      when 1
        Absorption::Coefficients.each do |item|
          if item[:material] == "brickwork"
           left_wall_coeffs = item[:coeffs]
          end
         end
        left_wall_coeffs.each do |frequency, coeff|
          left_wall_absorption[frequency] = (coeff * left_wall_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "plasterboard"
           left_wall_coeffs = item[:coeffs]
          end
         end
        left_wall_coeffs.each do |frequency, coeff|
          left_wall_absorption[frequency] = (coeff * left_wall_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end

    while true
      puts "\nRight wall:"
      puts "\n1. Brickwork".colorize(:green)
      puts "2. Plasterboard".colorize(:green)
      right_wall_type = gets.chomp.to_i
      case right_wall_type
      when 1
        Absorption::Coefficients.each do |item|
          if item[:material] == "brickwork"
           right_wall_coeffs = item[:coeffs]
          end
         end
        right_wall_coeffs.each do |frequency, coeff|
          right_wall_absorption[frequency] = (coeff * right_wall_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "plasterboard"
           right_wall_coeffs = item[:coeffs]
          end
         end
        right_wall_coeffs.each do |frequency, coeff|
          right_wall_absorption[frequency] = (coeff * right_wall_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end

    while true
      puts "\nDoors:"
      puts "\n1. Wooden with a hollow core".colorize(:green)
      puts "2. Solid timber".colorize(:green)
      door_type = gets.chomp.to_i
      case door_type
      when 1
        Absorption::Coefficients.each do |item|
          if item[:material] == "wood_hollow_door"
           door_coeffs = item[:coeffs]
          end
         end
        door_coeffs.each do |frequency, coeff|
          door_absorption[frequency] = (coeff * door_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "timber_solid_door"
           door_coeffs = item[:coeffs]
          end
         end
        door_coeffs.each do |frequency, coeff|
          door_absorption[frequency] = (coeff * door_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end

    while true
      puts "\nWindows:"
      puts "\n1. 4mm glass".colorize(:green)
      puts "2. 6mm glass".colorize(:green)
      window_type = gets.chomp.to_i
      case window_type
      when 1
        Absorption::Coefficients.each do |item|
          if item[:material] == "four_mm_glass"
           window_coeffs = item[:coeffs]
          end
         end
        window_coeffs.each do |frequency, coeff|
          window_absorption[frequency] = (coeff * window_surface_area).truncate(2)
        end
        break
      when 2
        Absorption::Coefficients.each do |item|
          if item[:material] == "six_mm_glass"
           window_coeffs = item[:coeffs]
          end
         end
        window_coeffs.each do |frequency, coeff|
          window_absorption[frequency] = (coeff * window_surface_area).truncate(2)
        end
        break
      else
        invalid_material()
      end
    end

    total_surface_area = floor_surface_area + ceiling_surface_area + front_wall_surface_area + back_wall_surface_area + left_wall_surface_area + right_wall_surface_area + door_surface_area + window_surface_area

    all_surfaces_coeffs = Array.new
    all_surfaces_coeffs.push(
      floor_absorption, 
      ceiling_absorption, 
      front_wall_absorption, 
      back_wall_absorption, 
      left_wall_absorption, 
      right_wall_absorption, 
      door_absorption, 
      window_absorption
    )

    total_absorption_125Hz = all_surfaces_coeffs.map{|freq| freq["125Hz"]}.inject(:+)
    total_absorption_250Hz = all_surfaces_coeffs.map{|freq| freq["250Hz"]}.inject(:+)
    total_absorption_500Hz = all_surfaces_coeffs.map{|freq| freq["500Hz"]}.inject(:+)
    total_absorption_1000Hz = all_surfaces_coeffs.map{|freq| freq["1000Hz"]}.inject(:+)
    total_absorption_2000Hz = all_surfaces_coeffs.map{|freq| freq["2000Hz"]}.inject(:+)
    total_absorption_4000Hz = all_surfaces_coeffs.map{|freq| freq["4000Hz"]}.inject(:+)

    total_absorption = {
      "125Hz" => total_absorption_125Hz,
      "250Hz" => total_absorption_250Hz,
      "500Hz" => total_absorption_500Hz,
      "1000Hz" => total_absorption_1000Hz,
      "2000Hz" => total_absorption_2000Hz,
      "4000Hz" => total_absorption_4000Hz
    }

    avg_absorption_coeff_125Hz = (total_absorption_125Hz / total_surface_area).truncate(2)
    avg_absorption_coeff_250Hz = (total_absorption_250Hz / total_surface_area).truncate(2)
    avg_absorption_coeff_500Hz = (total_absorption_500Hz / total_surface_area).truncate(2)
    avg_absorption_coeff_1000Hz = (total_absorption_1000Hz / total_surface_area).truncate(2)
    avg_absorption_coeff_2000Hz = (total_absorption_2000Hz / total_surface_area).truncate(2)
    avg_absorption_coeff_4000Hz = (total_absorption_4000Hz / total_surface_area).truncate(2)

    avg_absorption_coeffs = {
      "125Hz" => avg_absorption_coeff_125Hz,
      "250Hz" => avg_absorption_coeff_250Hz,
      "500Hz" => avg_absorption_coeff_500Hz,
      "1000Hz" => avg_absorption_coeff_1000Hz,
      "2000Hz" => avg_absorption_coeff_2000Hz,
      "4000Hz" => avg_absorption_coeff_4000Hz
    }

    puts "\nABSORPTION VALUES:".colorize(:light_yellow)
    puts "\nThe total absorption per octave band is:\n\n"
    net_absorption = 0.0
    total_absorption.each do |octave, absorption|
      puts "- #{octave}: #{absorption.truncate(2)} m2".colorize(:cyan)
      net_absorption += absorption
    end
    puts "\nThe net absortion of all octave bands is: %.2f m2" % [net_absorption]

    puts "\n============================="

    puts "\nSABINE REVERB TIME VALUES:".colorize(:light_yellow)
    puts "\nThe Sabine reverb times for each octave band are:\n\n"
    sabine_octave_bands = Hash.new
    total_absorption.each do |octave, absorption|
      reverb_time_sabine = sabine(room_volume, absorption)
      puts "- #{octave}: #{reverb_time_sabine} seconds".colorize(:cyan)
      sabine_octave_bands[octave] = reverb_time_sabine
    end
    sabine_mid_average = ((sabine_octave_bands["500Hz"] + sabine_octave_bands["1000Hz"]) / 2)
    puts "\nThe mid-frequency average (500Hz and 1000Hz) is: %.2f seconds" % [sabine_mid_average]

    puts "\n============================="

    puts "\nNORRIS-EYRING REVERB TIME VALUES:".colorize(:light_yellow)
    puts "\nThe Norris-Eyring reverb times for each octave band are:\n\n"
    eyring_octave_bands = Hash.new
    avg_absorption_coeffs.each do |octave, coeff|
      reverb_time_eyring = eyring(room_volume, total_surface_area, coeff)
      puts "- #{octave}: #{reverb_time_eyring} seconds".colorize(:cyan)
      eyring_octave_bands[octave] = reverb_time_eyring
    end
    eyring_mid_average = ((eyring_octave_bands["500Hz"] + eyring_octave_bands["1000Hz"]) / 2).truncate(2)
    puts "\nThe mid-frequency average (500Hz and 1000Hz) is: %.2f seconds" % [eyring_mid_average]

    puts "\n============================="

    another_calculation?()
  end

  ##### Reverb Time Equations ####
  def self.sabine(room_volume, absorption)
    reverb_sabine = ((0.16 * room_volume) / absorption).truncate(2)
    return reverb_sabine
  end

  def self.eyring(room_volume, total_surface_area, avg_absorption_coeff)
    reverb_eyring = ((0.16 * room_volume) / (-2.3 * total_surface_area * Math.log10(1 - avg_absorption_coeff))).truncate(2)
    return reverb_eyring
  end

  ##### Input Verifications #####
  def self.invalid_material()
    box = TTY::Box.frame("Invalid option! \nOnly 1 and 2 are accepted.".colorize(:red), width: 30, height: 6, border: :thick, align: :center, padding: [1,0,0,0], title: {top_left: " x ERROR "}).colorize(:red)
    puts
    puts box
    puts "Press any key to continue"
    gets
  end

  def self.invalid_input()
    box = TTY::Box.frame("Invalid input! \nOnly numbers above 0 are accepted.".colorize(:red), width: 30, height: 7, border: :thick, align: :center, padding: [1,0,1,1], title: {top_left: " x ERROR "}).colorize(:red)
    puts
    puts box
    puts "Press any key to continue"
    gets
  end

  ##### Repeat? #####
  def self.another_calculation?()
    puts "\nWould you like to make another RT calculation? (y/n)".colorize(:green)
    try_again = gets.chomp
    case try_again 
    when 'y'
      reverb_calculations()
    when 'n'
      puts "\nSee you later!".colorize(:light_yellow)
      exit!
    else
      Validators.invalid_yes_no()
      another_calculation?()
    end
  end

end
