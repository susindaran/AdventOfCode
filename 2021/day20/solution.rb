# frozen_string_literal: true

require_relative '../../aoc'

OFFSETS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 0], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

def out_of_bounds(grid, row, col)
  row.negative? || row >= grid.length || col.negative? || col >= grid[0].length
end

def get_enhancer_index(grid, row, col, default)
  OFFSETS.map do |offset|
    n_row, n_col = row + offset[0], col + offset[1]
    out_of_bounds(grid, n_row, n_col) ? default : grid[n_row][n_col]
  end.reduce(&:+).to_i(2)
end

def enhance(grid, enhancer, default)
  enhanced_grid = Array.new(grid.length + 2) { Array.new(grid.length + 2) }
  (-1..grid.length).each do |row|
    (-1..grid[0].length).each do |col|
      idx = get_enhancer_index(grid, row, col, default)
      enhanced_grid[row + 1][col + 1] = enhancer[idx]
    end
  end
  enhanced_grid
end

def solve(input, iterations)
  enhancer = input[0].strip.gsub('.', '0').gsub('#', '1').chars
  grid = input[2..].map { |x| x.strip.gsub('.', '0').gsub('#', '1').chars }

  default = '0'
  iterations.times do
    grid = enhance(grid, enhancer, default)
    # Pixels outside the given range are determined by the value in the enhancer.
    # Since they are dark pixels in the first iteration, the outside pixels in the next iteration are determined by
    # what is in the 0th position ('00000000'.to_i(2)) of enhancer. If 0th position happens to be a '#' then the
    # outer pixels all become '#' in the next iteration.
    default = enhancer[(default * 9).to_i(2)]
  end

  # grid.each do |row|
  #   puts row.join
  # end

  grid.map { |row| row.count { |x| x == '1' } }.sum
end

AOC.part1 do |input|
  solve(input, 2)
end

AOC.part2(read_lines: true) do |input|
  solve(input, 50)
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 5081
  raise unless part2_sol == 15_088
end
