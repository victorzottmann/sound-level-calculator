

# puts "Please input the following:"
# length = gets.to_f
# width = gets.to_f
# height = gets.to_f

# puts "What is the speed of sound (m/s)?"
# speed_of_sound = gets.to_f

# puts "How many modes? (1 - 10)"
# max_modes = gets.to_i

max_modes = 9

length = 4.6
width = 4
height = 3

speed_of_sound = 344

y = 0
z = 0

for x in 1..max_modes
  
  axial_modes = (speed_of_sound / 2) * Math.sqrt(((x / length) ** 2) + ((y / width) ** 2) + ((z / height) ** 2))

  puts "Axial mode #{x} = %.1f Hz" % [axial_modes]

  x += 1
end

puts "==="

for x in 1..max_modes
  
  axial_modes = (speed_of_sound / 2) * Math.sqrt(((x / length) ** 2) + ((y / width) ** 2) + ((z / height) ** 2))

  puts "Axial mode #{x} = %.1f Hz" % [axial_modes]

  x += 1
end
