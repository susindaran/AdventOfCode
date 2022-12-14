# frozen_string_literal: true

require_relative '../../aoc'

def out_of_bounds?(grid, row, col)
  row.negative? || row >= grid.length || col.negative? || col >= grid.first.length
end

def scenic_score(grid, row, col)
  [[-1, 0], [1, 0], [0, -1], [0, 1]].map do |move|
    view_dist = 0
    n_row, n_col = row + move.first, col + move.last

    until out_of_bounds?(grid, n_row, n_col)
      view_dist += 1
      break if grid[n_row][n_col] >= grid[row][col]

      n_row, n_col = n_row + move.first, n_col + move.last
    end
    view_dist
  end.reduce(&:*)
end

AOC.problem(read_lines: false) do |input|
  grid = input.split("\n").map { |line| line.chars.map(&:to_i) }
  rows, cols = grid.length, grid.first.length

  rows.times.map { |row| cols.times.map { |col| scenic_score(grid, row, col) }.max }.max
end
