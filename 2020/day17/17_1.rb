# frozen_string_literal: true

require_relative '../../aoc'

OFFSETS = [-1, 0, 1].each_with_object([]) { |z, arr| [-1, 0, 1].each { |x| [-1, 0, 1].each { |y| arr << [z, x, y] } } }

def within_bounds(grid, z, x, y)
  (z >= 0 && z < grid.length) && (x >= 0 && x < grid[0].length) && (y >= 0 && y < grid[0][0].length)
end

def get_active_neighbours(grid, z, x, y)
  active = 0
  OFFSETS.each do |(zoff, xoff, yoff)|
    next if zoff.zero? && xoff.zero? && yoff.zero?

    znew, xnew, ynew = z + zoff, x + xoff, y + yoff
    next unless within_bounds(grid, znew, xnew, ynew)

    active += 1 if grid[znew][xnew][ynew] == '#'
  end

  active
end

def change_states(grid)
  new_grid = Array.new(grid.length) { Array.new(grid[0].length) { Array.new(grid[0][0].length) } }

  grid.each_with_index do |space, z|
    space.each_with_index do |row, x|
      row.each_with_index do |state, y|
        active = get_active_neighbours(grid, z, x, y)
        case state
        when '.'
          new_grid[z][x][y] = active == 3 ? '#' : '.'
        when '#'
          new_grid[z][x][y] = (active < 2 || active > 3) ? '.' : '#'
        end
      end
    end
  end

  new_grid
end

def get_active(input_grid)
  i_rows, i_cols = input_grid.length, input_grid[0].length

  grid = Array.new(13) { Array.new(i_rows + 12) { Array.new(i_cols + 12, '.') } }
  z, x, y = 6, ((i_rows + 12) / 2) - (i_rows / 2), ((i_cols + 12) / 2) - (i_cols / 2)

  input_grid.each_with_index do |row, row_index|
    row.each_with_index do |state, col_index|
      grid[z][x + row_index][y + col_index] = state
    end
  end

  6.times { grid = change_states(grid) }
  grid.flatten.filter { |state| state == '#' }.length
end

AOC.problem do |input|
  grid = input.map(&:chomp).map { |line| line.split('') }
  get_active(grid)
end
