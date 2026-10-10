require "sdl2"
require "chunky_png"

class Renderer
  attr_reader :width, :height

  def initialize(width = 640, height = 480, title = "Rubik 4D")
    @width = width
    @height = height
    SDL2.init(SDL2::INIT_VIDEO | SDL2::INIT_EVENTS)
    @window = SDL2::Window.create(
      title,
      SDL2::Window::POS_CENTERED,
      SDL2::Window::POS_CENTERED,
      width,
      height,
      0
    )
    @renderer = @window.create_renderer(-1, 0)
    @pixels = "\xFF".b * (width * height * 4)
    @running = true
  end

  def clear(r = 255, g = 255, b = 255)
    @pixels = [b, g, r, 255].pack("C4") * (@width * @height)
  end

  def pset(x, y, r, g, b)
    x = x.to_i
    y = y.to_i
    return unless x >= 0 && x < @width
    return unless y >= 0 && y < @height

    i = (y * @width + x) * 4
    @pixels[i, 4] = [b, g, r, 255].pack("C4")
  end

  def line(x0, y0, x1, y1, r = 0, g = 0, b = 0)
    x0 = x0.to_i
    y0 = y0.to_i
    x1 = x1.to_i
    y1 = y1.to_i

    dx = (x1 - x0).abs
    dy = (y1 - y0).abs
    sx = x0 < x1 ? 1 : -1
    sy = y0 < y1 ? 1 : -1
    err = dx - dy

    loop do
      pset(x0, y0, r, g, b)
      break if x0 == x1 && y0 == y1

      e2 = 2 * err
      if e2 > -dy
        err -= dy
        x0 += sx
      end
      if e2 < dx
        err += dx
        y0 += sy
      end
    end
  end

  def save_png(path)
    image = ChunkyPNG::Image.new(@width, @height)

    @height.times do |y|
      @width.times do |x|
        i = (y * @width + x) * 4
        b, g, r, a = @pixels.byteslice(i, 4).unpack("C4")
        image[x, y] = ChunkyPNG::Color.rgba(r, g, b, a)
      end
    end

    image.save(path)
  end

  def present
    surface = SDL2::Surface.from_string(
      @pixels,
      @width,
      @height,
      32,
      @width * 4,
      0x00ff0000,
      0x0000ff00,
      0x000000ff,
      0xff000000
    )

    texture = @renderer.create_texture_from(surface)
    surface.destroy

    begin
      @renderer.copy(texture, nil, nil)
      @renderer.present
    ensure
      texture.destroy
    end
  end

  def poll_events
    while (event = SDL2::Event.poll)
      case event
      when SDL2::Event::Quit
        @running = false
      when SDL2::Event::KeyDown
        @running = false if event.sym == SDL2::Key::ESCAPE
      end
    end
    @running
  end

  def close
    @window.destroy if @window && !@window.destroy?
  end
end

