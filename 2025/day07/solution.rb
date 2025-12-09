# frozen_string_literal: true

require_relative '../../aoc'

AOC.part1(read_lines: true) do |input|
  grid = input.map(&:chars)
  rows, cols = grid.size, grid.first.size

  start = grid.first.find_index { |x| x == 'S' }
  queue = [[0, start]]
  splits = Set.new

  until queue.empty?
    pos = queue.pop
    next if pos[0] == rows - 1

    node = grid[pos[0]][pos[1]]

    if node == 'S' || node == '.'
      queue.push([pos[0] + 1, pos[1]])
    elsif node == '^'
      splits.add(pos)
      queue.push([pos[0] + 1, pos[1] - 1]) if pos[1] - 1 >= 0
      queue.push([pos[0] + 1, pos[1] + 1]) if pos[1] + 1 < cols
    end

    grid[pos[0]][pos[1]] = '|'
  end

  splits.size
end

def memoized(grid, row, col, mem)
  mem[[row, col]] = dfs(grid, row, col, mem) unless mem.key?([row, col])
  return mem[[row, col]]
end

def dfs(grid, row, col, mem)
  return 1 if row == grid.size - 1

  return 0 if row >= grid.size || col < 0 || col >= grid.first.size

  return memoized(grid, row + 1, col, mem) if grid[row][col] == 'S' || grid[row][col] == '.'

  return memoized(grid, row + 1, col - 1, mem) + memoized(grid, row + 1, col + 1, mem)
end

AOC.part2(read_lines: true) do |input|
  grid = input.map(&:chars)
  start_col = grid.first.find_index { |x| x == 'S' }

  dfs(grid, 0, start_col, {})
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 1600
  raise unless part2_sol == 8632253783011
end
