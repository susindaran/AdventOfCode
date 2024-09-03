# frozen_string_literal: true

require_relative '../../aoc'
require_relative '../../lib/priority_queue.rb'

OFFSETS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze
EXPANSION_FACTOR = 1

def valid_coord?(row, col, len)
  row >= 0 && row < len && col >= 0 && col < len
end

def get_cell_value(grid, row, col)
  len = grid.length
  ((grid[row % len][col % len] + (row / len) + (col / len) - 1) % 9) + 1
end

def bfs(grid)
  len = grid.length * EXPANSION_FACTOR

  visited = Array.new(len * EXPANSION_FACTOR) { Array.new(len * EXPANSION_FACTOR) }
  q = PQ.new { |a, b| a[2] <= b[2] }
  q.push [0, 0, 0]

  while !q.empty?
    row, col, risk = q.pop
    if visited[row][col] && visited[row][col] <= risk
      next
    else
      visited[row][col] = risk
    end

    # Short-circuit if we've reached the destination
    next if row == len - 1 && col == len - 1

    OFFSETS.each do |offset|
      n_row, n_col = row + offset[0], col + offset[1]

      # This will never be out of bounds because we clip row & col to grind length
      n_risk = risk + get_cell_value(grid, n_row, n_col)

      next if !valid_coord?(n_row, n_col, len) || (!visited[n_row][n_col].nil? && visited[n_row][n_col] < n_risk)

      q.push [n_row, n_col, n_risk]
    end
  end

  visited[len - 1][len - 1]
end

AOC.problem(read_lines: false) do |input|
  grid = input.split("\n").map { |line| line.chars.map(&:to_i) }
  bfs(grid)
end
