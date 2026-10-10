
require_relative "geometry"

point = [1.0, 0.0, 0.0, 0.0]

puts "Original: #{point.inspect}"
puts "XY 90°:   #{Geometry.rotate(point, 1, Math::PI / 2).inspect}"
puts "XW 90°:   #{Geometry.rotate(point, 3, Math::PI / 2).inspect}"

screen_point = Geometry.project(
  point,
  width: 640,
  height: 480
)

puts "Screen:   #{screen_point.inspect}"
