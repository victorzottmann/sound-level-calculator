
module SourceDistance

  def self.distance_calculation
    source_level = 85
    
    source_distance = 1 # metres
    receiver_distance = 1.2 # metres
    
    attenuation = 20 * Math.log10(receiver_distance / source_distance)
    
    level_difference = source_level - attenuation
    
    puts "\nThe sound source will be reduced from #{source_level} dB to #{level_difference.truncate(1)} dB at #{receiver_distance} metres."
    
    puts "\nThis results in a level difference of #{attenuation.truncate(1)} dB."
  end
  
end

# SourceDistance.distance_calculation()

