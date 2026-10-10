
require_relative "rubik4d"

model = Rubik4D.build

puts "Vertices: #{model[:vertices].size}"
puts "Edges:    #{model[:edges].size}"
puts "Sample:   #{model[:vertices].first.inspect}"
