
require_relative "renderer"
require_relative "geometry"
require_relative "rubik4d"

WIDTH = 640
HEIGHT = 480
FPS = 30.0
ROTATION_STEP = 0.025

screen = Renderer.new(WIDTH, HEIGHT, "Rubik 4D")

model = Rubik4D.build
vertices = model[:vertices]
edges = model[:edges]

angles = Hash.new(0.0)
plane = 3
direction = 1
auto_rotate = true

begin
  running = true

  while running
    frame_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    while (event = SDL2::Event.poll)
      case event
      when SDL2::Event::Quit
        running = false

      when SDL2::Event::KeyDown
        # キーリピートによる連続処理を避ける
        next if event.repeat rescue false

        case event.sym
        when SDL2::Key::ESCAPE, SDL2::Key::Q
          running = false
        when SDL2::Key::K1 then plane = 1
        when SDL2::Key::K2 then plane = 2
        when SDL2::Key::K3 then plane = 3
        when SDL2::Key::K4 then plane = 4
        when SDL2::Key::K5 then plane = 5
        when SDL2::Key::K6 then plane = 6
        when SDL2::Key::LEFT
          direction = -1
        when SDL2::Key::RIGHT
          direction = 1
        when SDL2::Key::SPACE
          auto_rotate = !auto_rotate
        when SDL2::Key::R
          angles.clear
        end
      end
    end

    break unless running

    angles[plane] += ROTATION_STEP * direction if auto_rotate

    screen.clear(18, 20, 28)

    projected = {}

    vertices.each do |point|
      rotated = Geometry.rotate_all(point, angles)

      projected[point] = Geometry.project(
        rotated,
        width: WIDTH,
        height: HEIGHT,
        distance: 4.0,
        scale: 105.0
      )
    end

    edges.each do |edge|
      p1 = projected[edge[0]]
      p2 = projected[edge[1]]
      next unless p1 && p2

      screen.line(
        p1[0], p1[1],
        p2[0], p2[1],
        100, 190, 235
      )
    end

    screen.present

    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - frame_start
    sleep([1.0 / FPS - elapsed, 0].max)
  end
ensure
  screen.close
end
