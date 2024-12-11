# frozen_string_literal: true

require_relative '../../aoc'

REGEX = /(?=(XMAS|SAMX))/

AOC.part1(read_lines: false) do |input|
  input = input.split("\n")
  grid = input.map(&:chars)

  # Horizontals
  # Uses positive lookahead `?=` to capture overlapping matches like 'XMASAMX'
  h = input.sum { |line| line.scan(REGEX).flatten.size }

  # Verticals
  v = grid.transpose.sum { |line| line.join.scan(REGEX).flatten.size }

  rows = grid.size
  padding = (0...rows).map { |i| [nil] * i }

  # Get the positive and negative diagonals
  diags = padding.reverse.zip(grid).zip(padding).map(&:flatten).transpose.map(&:compact)
  diags += padding.zip(grid).zip(padding.reverse).map(&:flatten).transpose.map(&:compact)

  d = diags.sum { |diag| diag.join.scan(REGEX).flatten.size }

  h + v + d
end

AOC.part2(read_lines: false) do |input|
  grid = input.split("\n").map(&:chars)
  (1...grid.size - 1).sum do |row|
    (1...grid.size - 1).count do |col|
      next unless grid[row][col] == 'A'

      d1 = [[-1, -1], [0, 0], [1, 1]].map { |offset| grid[row + offset[0]][col + offset[1]] }.join
      d2 = [[1, -1], [0, 0], [-1, 1]].map { |offset| grid[row + offset[0]][col + offset[1]] }.join

      d1.match?(/MAS|SAM/) && d2.match?(/MAS|SAM/)
    end
  end
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 2_500
  raise unless part2_sol == 1_933
end
