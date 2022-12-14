# frozen_string_literal: true

require_relative '../../aoc'

def out_of_bounds?(grid, row, col)
  row.negative? || row >= grid.length || col.negative? || col >= grid.first.length
end

def visible?(grid, row, col)
  [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |move|
    n_row, n_col = row + move.first, col + move.last

    until out_of_bounds?(grid, n_row, n_col) || grid[n_row][n_col] >= grid[row][col]
      n_row, n_col = n_row + move.first, n_col + move.last
    end

    return true if out_of_bounds?(grid, n_row, n_col)
  end

  false
end

AOC.problem(read_lines: false) do |input|
  grid = input.split("\n").map { _1.chars.map(&:to_i) }
  rows, cols = grid.length, grid.first.length

  rows.times.sum { |row| cols.times.count { |col| visible?(grid, row, col) } }
end
