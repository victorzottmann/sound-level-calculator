
total = 0.0
absorption = [
  {
    material: "concrete", 
    coeffs: {
      "125Hz": 0.01,
      "250Hz": 0.01,
      "500Hz": 0.01,
      "1000Hz": 0.02,
      "2000Hz": 0.02,
      "4000Hz": 0.02
    }
  },

  {
    material: "brickwork",
    coeffs: {
      "125Hz" => 0.05,
      "250Hz" => 0.04,
      "500Hz" => 0.02,
      "1000Hz" => 0.04,
      "2000Hz" => 0.05,
      "4000Hz" => 0.05
    }
  },

  {
    material: "thin_carpet_concrete",
    coeffs: {
      "125Hz" => 0.10,
      "250Hz" => 0.15,
      "500Hz" => 0.25,
      "1000Hz" => 0.30,
      "2000Hz" => 0.30,
      "4000Hz" => 0.30
    }
  },
  
  {
    material: "mineral_wool_tiles",
    coeffs: {
      "125Hz" => 0.06,
      "250Hz" => 0.40,
      "500Hz" => 0.75,
      "1000Hz" => 0.95,
      "2000Hz" => 0.96,
      "4000Hz" => 0.83
    }
  }
]

floor = absorption[2][:coeffs].values
puts floor

# absorption.each do |item|
#  if item[:material] == "concrete"
#   puts item[:coeffs]
#  end
# end

# absorption.each do |material|
#   total += material[:coeffs]["125Hz"]
# end

# puts total

# avg_absorption_125Hz = (all_surfaces_coeffs.map{|freq| freq["125Hz"]}.inject(:+)) / all_surfaces_coeffs.count
# avg_absorption_250Hz = (all_surfaces_coeffs.map{|freq| freq["250Hz"]}.inject(:+)) / all_surfaces_coeffs.count
# avg_absorption_500Hz = (all_surfaces_coeffs.map{|freq| freq["500Hz"]}.inject(:+)) / all_surfaces_coeffs.count
# avg_absorption_1000Hz = (all_surfaces_coeffs.map{|freq| freq["1000Hz"]}.inject(:+)) / all_surfaces_coeffs.count
# avg_absorption_2000Hz = (all_surfaces_coeffs.map{|freq| freq["2000Hz"]}.inject(:+)) / all_surfaces_coeffs.count
# avg_absorption_4000Hz = (all_surfaces_coeffs.map{|freq| freq["4000Hz"]}.inject(:+)) / all_surfaces_coeffs.count