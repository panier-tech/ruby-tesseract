
require_relative "renderer"

screen = Renderer.new(640, 480)
screen.clear(18, 20, 28)
screen.line(100, 100, 500, 380, 100, 190, 235)
screen.save_png("test.png")
screen.close
