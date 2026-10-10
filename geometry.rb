
module Geometry
  PLANES = {
    1 => [0, 1], # XY
    2 => [0, 2], # XZ
    3 => [0, 3], # XW
    4 => [1, 2], # YZ
    5 => [1, 3], # YW
    6 => [2, 3]  # ZW
  }.freeze

  PLANE_NAMES = {
    1 => "XY",
    2 => "XZ",
    3 => "XW",
    4 => "YZ",
    5 => "YW",
    6 => "ZW"
  }.freeze

  module_function

  # 4次元座標を指定した平面で回転する
  def rotate(point, plane, angle)
    i, j = PLANES.fetch(plane)
    result = point.dup

    c = Math.cos(angle)
    s = Math.sin(angle)

    a = point[i]
    b = point[j]

    result[i] = a * c - b * s
    result[j] = a * s + b * c

    result
  end

  # 複数の回転を順番に適用する
  def rotate_all(point, angles)
    angles.reduce(point.dup) do |p, (plane, angle)|
      rotate(p, plane, angle)
    end
  end

  # 4D -> 3D の透視投影
  def project_4d(point, distance = 4.0)
    x, y, z, w = point

    denominator = distance - w
    return nil if denominator <= 0.01

    scale = distance / denominator

    [
      x * scale,
      y * scale,
      z * scale
    ]
  end

  # 3D -> 2D の斜投影
  def project_3d(point, width:, height:, scale: 115.0)
    x, y, z = point

    screen_x = width / 2.0 + scale * (x - 0.5 * z)
    screen_y = height / 2.0 - scale * (y - 0.35 * z)

    [screen_x, screen_y]
  end

  # 4D -> 画面座標
  def project(point, width:, height:, distance: 4.0, scale: 115.0)
    point_3d = project_4d(point, distance)
    return nil unless point_3d

    project_3d(
      point_3d,
      width: width,
      height: height,
      scale: scale
    )
  end
end
