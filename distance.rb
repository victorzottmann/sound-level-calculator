
module SourceDistance

  def self.attenuation()
    source_level = 85
    
    source_distance = 1 # metres
    receiver_distance = 1.2 # metres
    
    receiver_level = 20 * Math.log10(receiver_distance / source_distance)
    
    level_difference = source_level - receiver_level
    
    puts "\nThe sound source will be reduced from #{source_level} dB to #{level_difference.truncate(1)} dB at #{receiver_distance} metres."
    
    puts "\nThis results in a level difference of #{receiver_level.truncate(1)} dB."
  end

  def self.speed_of_sound(temperature)
    speed = (331.3 * Math.sqrt(1 + (temperature / 273.15))).truncate(0)
    return speed
  end
  
end

# puts SourceDistance.speed_of_sound(20)

