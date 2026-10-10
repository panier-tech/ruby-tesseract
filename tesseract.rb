module Rubik4D
  SIZE = 1.0
  DIVISIONS = 1

  GRID = (0..DIVISIONS).map do |i|
    -SIZE + 2.0 * SIZE * i / DIVISIONS
  end.freeze

  def self.build
    vertices = {}
    edges = {}

    4.times do |fixed_axis|
      other_axes = (0...4).to_a - [fixed_axis]

      [-SIZE, SIZE].each do |side|
        indices_range = 0..DIVISIONS

        indices_range.each do |a|
          indices_range.each do |b|
            indices_range.each do |c|
              indices = [a, b, c]
              point = Array.new(4)
              point[fixed_axis] = side

              other_axes.each_with_index do |axis, i|
                point[axis] = GRID[indices[i]]
              end

              vertices[point.freeze] = true
            end
          end
        end

        indices_range.each do |a|
          indices_range.each do |b|
            indices_range.each do |c|
              indices = [a, b, c]

              3.times do |axis_index|
                next if indices[axis_index] >= DIVISIONS

                next_indices = indices.dup
                next_indices[axis_index] += 1

                p1 = Array.new(4)
                p2 = Array.new(4)

                p1[fixed_axis] = side
                p2[fixed_axis] = side

                other_axes.each_with_index do |axis, i|
                  p1[axis] = GRID[indices[i]]
                  p2[axis] = GRID[next_indices[i]]
                end

                key1 = p1.freeze
                key2 = p2.freeze
                edge = [key1, key2].sort_by(&:to_s)

                edges[edge] = true
              end
            end
          end
        end
      end
    end

    {
      vertices: vertices.keys,
      edges: edges.keys
    }
  end
end

