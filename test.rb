rough_concrete = {
  "125Hz": 0.02,
  "250Hz": 0.03,
  "500Hz": 0.03,
  "1000Hz": 0.03,
  "2000Hz": 0.04,
  "4000Hz": 0.07
}

thin_carpet_concrete = {
  "125Hz": 0.10,
  "250Hz": 0.15,
  "500Hz": 0.25,
  "1000Hz": 0.30,
  "2000Hz": 0.30,
  "4000Hz": 0.30
}

standard_brickwork = {
  "125Hz": 0.05,
  "250Hz": 0.04,
  "500Hz": 0.02,
  "1000Hz": 0.04,
  "2000Hz": 0.05,
  "4000Hz": 0.05
}

mineral_wool_tiles = {
  "125Hz": 0.06,
  "250Hz": 0.40,
  "500Hz": 0.75,
  "1000Hz": 0.95,
  "2000Hz": 0.96,
  "4000Hz": 0.83
}

floor_surface_area = 90.2
ceiling_surface_area = 90.2
walls_large_surface_area = 27.5
walls_small_surface_area = 20.5

total_sa = 228.4
volume = 225.5

floor_coeffs = thin_carpet_concrete
ceiling_coeffs = mineral_wool_tiles
walls_large_coeffs = standard_brickwork
walls_small_coeffs = standard_brickwork

floor_absorption = Hash.new
ceiling_absorption = Hash.new
walls_large_absorption = Hash.new
walls_small_absorption = Hash.new

floor_coeffs.each do |freq, value|
  result = value * floor_surface_area
  floor_absorption[freq] = result
end

ceiling_coeffs.each do |freq, value|
  result = value * ceiling_surface_area
  ceiling_absorption[freq] = result
end

walls_large_coeffs.each do |freq, value|
  result = value * ceiling_surface_area
  walls_large_absorption[freq] = result
end

walls_small_coeffs.each do |freq, value|
  result = value * ceiling_surface_area
  walls_small_absorption[freq] = result
end



