# frozen_string_literal: true

require_relative '../../aoc'

NORTH = 1 << 0
EAST  = 1 << 1
SOUTH = 1 << 2
WEST  = 1 << 3

TURN_RIGHT = {
  NORTH => EAST,
  EAST => SOUTH,
  SOUTH => WEST,
  WEST => NORTH
}.freeze

MOVE = {
  NORTH => [-1, 0],
  EAST => [0, 1],
  SOUTH => [1, 0],
  WEST => [0, -1]
}.freeze

def parse_input(input)
  r, c = 0, 0
  grid = input.split("\n").each_with_index.map do |line, row|
    r, c = row, line.index('^') if line.index('^')
    line.chars
  end

  [grid, r, c]
end

def move(row, col, dir, reverse: false)
  multiplier = reverse ? -1 : 1
  [row + (MOVE[dir][0] * multiplier), col + (MOVE[dir][1] * multiplier)]
end

AOC.part1(read_lines: false) do |input|
  grid, r, c = parse_input(input)

  dir = NORTH

  while r < grid.size && c < grid[0].size
    if grid[r][c] != '#'
      grid[r][c] = 'X'
    elsif grid[r][c] == '#'
      # If encountered an obstacle, take a step back and turn right
      r, c = move(r, c, dir, reverse: true)
      dir = TURN_RIGHT[dir]
    end
    r, c = move(r, c, dir)
  end

  grid.sum { |line| line.count { _1 == 'X' } }
end

def deep_copy(grid)
  grid.map(&:dup)
end

def loop?(grid, r, c, dir)
  while r >= 0 && r < grid.size && c >= 0 && c < grid[0].size
    if grid[r][c] == '#'
      r, c = move(r, c, dir, reverse: true)
      grid[r][c] = 0 if grid[r][c].is_a?(String)
      return true if (grid[r][c] & dir).positive?

      grid[r][c] = (grid[r][c] | dir)
      dir = TURN_RIGHT[dir]
    end
    r, c = move(r, c, dir)
  end

  false
end

AOC.part2(read_lines: false) do |input|
  grid, start_r, start_c = parse_input(input)

  dir = NORTH

  r, c = start_r, start_c
  res = 0

  # Traverse the grid as usual, and for each valid location on the path that is not already an
  # obstacle or the starting position, place a new obstacle and check for loop
  while r >= 0 && r < grid.size && c >= 0 && c < grid[0].size
    if grid[r][c] == '#'
      r, c = move(r, c, dir, reverse: true)
      dir = TURN_RIGHT[dir]
    elsif grid[r][c] != '^' && grid[r][c] != 'X'
      grid[r][c] = 'X' # Mark the grid with 'X' so that we don't try to check for the same spot again
      dup_grid = deep_copy(grid)
      dup_grid[r][c] = '#'
      res += 1 if loop?(dup_grid, start_r, start_c, NORTH)
    end

    r, c = move(r, c, dir)
  end

  res
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 4_515
  raise unless part2_sol == 1_309
end
