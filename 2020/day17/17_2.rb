# frozen_string_literal: true

require_relative '../../aoc'

OFFSETS = [-1, 0, 1].each_with_object([]) do |w, arr|
  [-1, 0, 1].each do |z|
    [-1, 0, 1].each do |x|
      [-1, 0, 1].each do |y|
        next if w.zero? && z.zero? && x.zero? && y.zero?

        arr << [w, z, x, y]
      end
    end
  end
end

def within_bounds(grid, w, z, x, y)
  (w >= 0 && w < grid.length) &&
    (z >= 0 && z < grid[0].length) &&
    (x >= 0 && x < grid[0][0].length) &&
    (y >= 0 && y < grid[0][0][0].length)
end

def get_active_neighbours(grid, w, z, x, y)
  active = 0
  OFFSETS.each do |(woff, zoff, xoff, yoff)|
    wnew, znew, xnew, ynew = w + woff, z + zoff, x + xoff, y + yoff
    next unless within_bounds(grid, wnew, znew, xnew, ynew)

    active += 1 if grid[wnew][znew][xnew][ynew] == '#'
  end

  active
end

def change_states(grid)
  new_grid = Array.new(grid.length) do
    Array.new(grid[0].length) { Array.new(grid[0][0].length) { Array.new(grid[0][0][0].length) } }
  end

  grid.each_with_index do |wrap, w|
    wrap.each_with_index do |space, z|
      space.each_with_index do |row, x|
        row.each_with_index do |state, y|
          active = get_active_neighbours(grid, w, z, x, y)
          case state
          when '.'
            new_grid[w][z][x][y] = active == 3 ? '#' : '.'
          when '#'
            new_grid[w][z][x][y] = (active < 2 || active > 3) ? '.' : '#'
          end
        end
      end
    end
  end

  new_grid
end

def get_active(input_grid)
  i_rows, i_cols = input_grid.length, input_grid[0].length

  grid = Array.new(13) { Array.new(13) { Array.new(i_rows + 12) { Array.new(i_cols + 12, '.') } } }

  w, z, x, y = 6, 6, ((i_rows + 12)/2) - (i_rows / 2), ((i_cols + 12)/2) - (i_cols / 2)
  input_grid.each_with_index do |row, row_index|
    row.each_with_index do |state, col_index|
      grid[w][z][x + row_index][y + col_index] = state
    end
  end

  6.times { grid = change_states(grid) }
  grid.flatten.filter { |state| state == '#' }.length
end

AOC.problem do |input|
  grid = input.map(&:chomp).map { |line| line.split('') }
  get_active(grid)
end
