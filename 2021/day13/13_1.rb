# frozen_string_literal: true

require_relative '../../aoc'

def must_fold?(coord, axis, offset)
  return coord[0] > offset if axis == 'x'
  return coord[1] > offset if axis == 'y'
end

def fold(mat, axis, offset)
  mat.keys.each do |coord|
    next unless must_fold?(coord, axis, offset)

    mat.delete(coord)
    if axis == 'x'
      coord[0] -= ((coord[0] - offset) * 2)
    else
      coord[1] -= ((coord[1] - offset) * 2)
    end
    mat[coord] = true
  end
end

AOC.problem(read_lines: false) do |input|
  points, folds = input.split("\n\n").map { |sec| sec.split("\n") }

  mat = {}
  points.map.each_with_object(mat) { |point, m| m[point.split(',').map(&:to_i)] = true }

  folds.each_with_index do |fold, idx|
    fold_axis, fold_offset = fold.split('=')
    fold(mat, fold_axis[-1], fold_offset.to_i)
    puts "After step #{idx + 1}: #{mat.values.size} points"
  end

  max_x, max_y = mat.keys.map(&:first).max, mat.keys.map(&:last).max
  (0..max_y).map { |y| (0..max_x).map { |x| mat[[x, y]] ? '#' : '.' }.join(' ') }.join("\n")
end
