absorption = [
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
  }
]

floor_surface_area = 90.2
ceiling_surface_area = 90.2
large_walls_surface_area = 27.5
small_walls_surface_area = 20.5

room_volume = 225.5

total_surface_area = floor_surface_area + ceiling_surface_area + large_walls_surface_area + small_walls_surface_area


floor_coeffs = absorption[0][:coeffs]
ceiling_coeffs = absorption[1][:coeffs]
large_walls_coeffs = absorption[2][:coeffs]
small_walls_coeffs = absorption[2][:coeffs]

floor_absorption = {}
ceiling_absorption = {}
large_walls_absorption = {}
small_walls_absorption = {}

floor_coeffs.each do |frequency, coeff|
  floor_absorption[frequency] = (coeff * floor_surface_area).truncate(2)
end

ceiling_coeffs.each do |frequency, coeff|
  ceiling_absorption[frequency] = (coeff * ceiling_surface_area).truncate(2)
end

large_walls_coeffs.each do |frequency, coeff|
  large_walls_absorption[frequency] = (coeff * large_walls_surface_area).truncate(2)
end

small_walls_coeffs.each do |frequency, coeff|
  small_walls_absorption[frequency] = (coeff * small_walls_surface_area).truncate(2)
end

abs_array = []
abs_array.push(floor_absorption, ceiling_absorption, large_walls_absorption, small_walls_absorption)

total_absorption_125Hz = abs_array.map{|freq| freq["125Hz"]}.inject(:+)
total_absorption_250Hz = abs_array.map{|freq| freq["250Hz"]}.inject(:+)
total_absorption_500Hz = abs_array.map{|freq| freq["500Hz"]}.inject(:+)
total_absorption_1000Hz = abs_array.map{|freq| freq["1000Hz"]}.inject(:+)
total_absorption_2000Hz = abs_array.map{|freq| freq["2000Hz"]}.inject(:+)
total_absorption_4000Hz = abs_array.map{|freq| freq["4000Hz"]}.inject(:+)

avg_absorption_125Hz = (abs_array.map{|freq| freq["125Hz"]}.inject(:+)) / abs_array.count
avg_absorption_250Hz = (abs_array.map{|freq| freq["250Hz"]}.inject(:+)) / abs_array.count
avg_absorption_500Hz = (abs_array.map{|freq| freq["500Hz"]}.inject(:+)) / abs_array.count
avg_absorption_1000Hz = (abs_array.map{|freq| freq["1000Hz"]}.inject(:+)) / abs_array.count
avg_absorption_2000Hz = (abs_array.map{|freq| freq["2000Hz"]}.inject(:+)) / abs_array.count
avg_absorption_4000Hz = (abs_array.map{|freq| freq["4000Hz"]}.inject(:+)) / abs_array.count

avg_absorption_coeff_125Hz = (total_absorption_125Hz / total_surface_area).truncate(2)
avg_absorption_coeff_250Hz = (total_absorption_250Hz / total_surface_area).truncate(2)
avg_absorption_coeff_500Hz = (total_absorption_500Hz / total_surface_area).truncate(2)
avg_absorption_coeff_1000Hz = (total_absorption_1000Hz / total_surface_area).truncate(2)
avg_absorption_coeff_2000Hz = (total_absorption_2000Hz / total_surface_area).truncate(2)
avg_absorption_coeff_4000Hz = (total_absorption_4000Hz / total_surface_area).truncate(2)


reverb_eyring = ((0.16 * room_volume) / (-2.3 * total_surface_area * Math.log10(1 - avg_absorption_coeff_125Hz))).truncate(2)

# puts "125: #{total_absorption_125Hz}"

total_absorption = {
  "125Hz" => total_absorption_125Hz,
  "250Hz" => total_absorption_250Hz,
  "500Hz" => total_absorption_500Hz,
  "1000Hz" => total_absorption_1000Hz,
  "2000Hz" => total_absorption_2000Hz,
  "4000Hz" => total_absorption_4000Hz
}

avg_coeffs = {
  "125Hz" => avg_absorption_coeff_125Hz,
  "250Hz" => avg_absorption_coeff_250Hz,
  "500Hz" => avg_absorption_coeff_500Hz,
  "1000Hz" => avg_absorption_coeff_1000Hz,
  "2000Hz" => avg_absorption_coeff_2000Hz,
  "4000Hz" => avg_absorption_coeff_4000Hz
}

puts "The total absorption per octave band is:"
net_absorption = 0.0
total_absorption.each do |octave, abs|
  puts "- #{octave}: #{abs.truncate(2)} m2"
  net_absorption += abs
end
puts "\nThe total absortion is: #{net_absorption} m2"

puts "\nThe Sabine reverb times for each octave band are: "
sabine_rt = Hash.new
total_absorption.each do |octave, abs|
  reverb_sabine = ((0.16 * room_volume) / abs).truncate(2)
  puts "- #{octave}: #{reverb_sabine} seconds"
  sabine_rt[octave] = reverb_sabine
end
sabine_mid_average = ((sabine_rt["500Hz"] + sabine_rt["1000Hz"]) / 2).truncate(2)
puts "\nThe Sabine mid-frequency average is: #{sabine_mid_average} seconds"

puts "\nThe Eyring reverb times for each octave band are:\n\n"
eyring_rt = Hash.new
avg_coeffs.each do |octave, coeff|
  reverb_eyring = ((0.16 * room_volume) / (-2.3 * total_surface_area * Math.log10(1 - coeff))).truncate(2)
  puts "- #{octave}: #{reverb_eyring} seconds"
  eyring_rt[octave] = reverb_eyring
end
eyring_mid_average = ((eyring_rt["500Hz"] + eyring_rt["1000Hz"]) / 2).truncate(2)
puts "\nThe Eyring mid-frequency average is: #{eyring_mid_average} seconds"


# avg_absorption_coeff_125Hz = (total_absorption_125Hz / total_surface_area).truncate(2)
# avg_absorption_coeff_250Hz = (total_absorption_250Hz / total_surface_area).truncate(2)
# avg_absorption_coeff_500Hz = (total_absorption_500Hz / total_surface_area).truncate(2)
# avg_absorption_coeff_1000Hz = (total_absorption_1000Hz / total_surface_area).truncate(2)
# avg_absorption_coeff_2000Hz = (total_absorption_2000Hz / total_surface_area).truncate(2)
# avg_absorption_coeff_4000Hz = (total_absorption_4000Hz / total_surface_area).truncate(2)  

# avg_coeffs = {
#   "125Hz" => avg_absorption_coeff_125Hz,
#   "250Hz" => avg_absorption_coeff_250Hz,
#   "500Hz" => avg_absorption_coeff_500Hz,
#   "1000Hz" => avg_absorption_coeff_1000Hz,
#   "2000Hz" => avg_absorption_coeff_2000Hz,
#   "4000Hz" => avg_absorption_coeff_4000Hz
# }
