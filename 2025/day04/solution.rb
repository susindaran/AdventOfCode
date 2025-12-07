# frozen_string_literal: true

require_relative '../../aoc'

DIRS = (-1..1).flat_map {|x| (-1..1).map {|y| [x, y] unless x == 0 && y == 0}.compact}.freeze

def check(grid, x, y)
  return false if x < 0 || x >= grid.size || y < 0 || y >= grid.first.size

  grid[y][x] == '@'
end

def solve(grid, break_condition)
  rows, cols = grid.size, grid.first.size

  total_count = 0
  copy = Array.new(rows) { Array.new(cols) }

  loop do
    count = 0
    (0...rows).each do |y|
      (0...cols).each do |x|
        if grid[y][x] == '@' && DIRS.sum { |dir| check(grid, x + dir[1], y + dir[0]) ? 1 : 0 } < 4
          count += 1
          copy[y][x] = '.'
          next
        end

        copy[y][x] = grid[y][x]
      end
    end

    grid, copy = copy, grid
    total_count += count

    break if break_condition.call(count)
  end

  total_count
end

AOC.part1(read_lines: true) do |input|
  grid = input.map(&:chars)

  # Just one iteration
  condition = -> (_) { true }
  solve(grid, condition)
end

AOC.part2(read_lines: true) do |input|
  grid = input.map(&:chars)

  # Iterate until count doesn't increase
  condition = -> (count) { count.zero? }
  solve(grid, condition)
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 1424
  raise unless part2_sol == 8727
end
