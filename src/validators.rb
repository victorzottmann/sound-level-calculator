
require 'tty-box'

module Validators


  def self.validate_temperature(temperature)
    temperature = temperature.to_f
    if temperature > 0
      return true
    else
      return false
    end
  end

  # spl = sound pressure level
  def self.validate_pressure_levels(levels)
    levels.each do |i|
      if i > 0
        return true
      else
        return false
      end
    end
  end

  def self.validate_level(level)
    if level > 0
      return true
    else
      return false
    end
  end

  def self.validate_distance(distance)
    if distance > 0
      return true
    else
      return false
    end
  end

  def self.invalid_yes_no()
    box = TTY::Box.frame("Invalid input! \nOnly (y/n) are accepted.", width: 30, height: 6, border: :thick, align: :center, padding: [1,0,0,0], title: {top_left: " x ERROR "}).colorize(:red)
    puts
    puts box
    puts "Press any key and Enter to continue"
    gets
  end

  # def self.validate_input(input)
  #   input = input.to_i
  #   if input > 0 && input < 5
  #     return true
  #   else
  #     return false
  #   end
  # end

  def self.validate_room_dimensions(dimension)
    dimension_number = dimension.to_f
    if dimension_number > 0
      return true
    else
      return false
    end
  end

  def self.validate_material(choice)
    choice = choice.to_i
    if choice > 0 && choice < 3
      return true
    else
      return false
    end
  end

  def self.invalid_material_error()
    box = TTY::Box.frame("Invalid option! \nOnly 1 or 2 are accepted.".colorize(:red), width: 30, height: 6, border: :thick, align: :center, padding: [1,0,0,0], title: {top_left: " x ERROR "}).colorize(:red)
    puts
    puts box
    puts "Press any key and Enter to continue"
    gets
  end

  def self.invalid_number_error()
    box = TTY::Box.frame("Invalid input! \nOnly numbers above 0 are accepted.".colorize(:red), width: 30, height: 7, border: :thick, align: :center, padding: [1,0,1,1], title: {top_left: " x ERROR "}).colorize(:red)
    puts
    puts box
    puts "Press any key and Enter to continue"
    gets
  end

end