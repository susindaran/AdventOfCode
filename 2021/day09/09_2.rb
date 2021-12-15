# frozen_string_literal: true

require_relative '../../aoc'

DIRS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

def dfs(mat, row, col)
  return 0 if mat[[row, col]].nil? || mat[[row, col]] == 9

  mat[[row, col]] = nil
  DIRS.sum { |dir| dfs(mat, row + dir[0], col + dir[1]) } + 1
end

AOC.problem do |input|
  mat = input.each_with_index.map do |line, row|
    line.strip.chars.each_with_index.map { |e, col| [[row, col], e.to_i] }.to_h
  end.reduce(:merge)

  low_points = []
  (0...input.length).each do |row|
    (0...input[row].strip.length).each do |col|
      low_points << [row, col] if DIRS.all? { |dir| mat[[row, col]] < (mat[[row + dir[0], col + dir[1]]] || 10) }
    end
  end

  low_points.map { |low_point| dfs(mat, low_point.first, low_point.last) }.sort.last(3).reduce(:*)
end
