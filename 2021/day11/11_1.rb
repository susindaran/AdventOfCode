# frozen_string_literal: true

require 'pry'
require_relative '../../aoc'

DIRS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

def propogate_flash(mat, pos)
  mat[pos] = 0

  DIRS.each_with_object([]) do |dir, to_flash|
    neighbour = [pos[0] + dir[0], pos[1] + dir[1]]
    val = mat[neighbour]
    unless val.nil? || val.zero?
      mat[neighbour] = val + 1
      to_flash << neighbour if val == 9
    end

    to_flash
  end
end

AOC.problem do |input|
  # Convert to hash[[row, col]] = val
  mat = input.each_with_index.map do |line, row|
    line.strip.chars.each_with_index.map { |e, col| [[row, col], e.to_i] }.to_h
  end.reduce(:merge)

  flashes = 0
  100.times do
    mat.transform_values! { |v| v + 1 }

    to_flash = mat.keys.select { |k| mat[k] > 9 }

    until to_flash.empty?
      to_flash += propogate_flash(mat, to_flash.pop)
      flashes += 1
    end
  end

  flashes
end
