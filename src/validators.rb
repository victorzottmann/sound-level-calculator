
require 'tty-box'

module Validators

  def self.invalid_yes_no()
    box = TTY::Box.frame("Invalid input! \nOnly (y/n) are accepted.", width: 30, height: 6, border: :thick, align: :center, padding: [1,0,0,0], title: {top_left: " x ERROR "}).colorize(:red)
    puts
    puts box
    puts "Press any key to continue"
    gets
  end

  def self.validate_input(input)
    input = input.to_i
    if input > 0 && input < 5
      return true
    else
      return false
    end
  end

  def self.validate_surface_area(area)
    surface_area = area.to_f
    if surface_area > 0
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
end