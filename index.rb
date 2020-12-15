require 'colorize'
require 'tty-prompt'
require_relative 'src/general-calculations'
require_relative 'src/sound-level'
require_relative 'src/reverb-time'
  
def self.intro()
  system("clear")

  include General
  include SoundLevel
  include ReverbTime

  prompt = TTY::Prompt.new

  puts "\nHello! Welcome to this simple acoustics calculator.".colorize(:light_yellow)

  options = ["General Calculations", "Sound Level", "Reverberation Time (RT)", "Exit"]
  input = prompt.select("\nWhat would you like to calculate?\n", options)
  case input
  when "General Calculations"
    General.general_calculations()

  when "Sound Level"
    SoundLevel.level_calculations()

  when "Reverberation Time (RT)"
    ReverbTime.reverb_calculations()

  when "Exit"
    puts "\nSee you later!".colorize(:light_yellow)
    exit!
  end
end

intro()



