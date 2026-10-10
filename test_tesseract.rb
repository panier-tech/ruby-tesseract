
require_relative "tesseract"

model = Rubik4D.build

puts "Vertices: #{model[:vertices].size}"
puts "Edges:    #{model[:edges].size}"
puts "Sample:   #{model[:vertices].first.inspect}"
