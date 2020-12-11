# frozen_string_literal: true

require_relative '../../aoc'

def row_within_bounds(layout, row)
  row >= 0 && row < layout.length
end

def col_within_bounds(layout, col)
  col >= 0 && col < layout[0].length
end

def count_adjacent_occupied(layout, row, col)
  occupied = 0

  # Check left
  (col - 1).downto(0).each_with_object(row) do |new_col, new_row|
    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  # Check right
  (col + 1...layout[0].length).each_with_object(row) do |new_col, new_row|
    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  # Check Top
  (row - 1).downto(0).each_with_object(col) do |new_row, new_col|
    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  # Check Down
  (row + 1...layout.length).each_with_object(col) do |new_row, new_col|
    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  # Check NW
  (1...layout.length).each do |offset|
    new_row, new_col = row - offset, col - offset
    break unless row_within_bounds(layout, new_row) && col_within_bounds(layout, new_col)

    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  # Check NE
  (1...layout.length).each do |offset|
    new_row, new_col = row - offset, col + offset
    break unless row_within_bounds(layout, new_row) && col_within_bounds(layout, new_col)

    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  # Check SW
  (1...layout.length).each do |offset|
    new_row, new_col = row + offset, col - offset
    break unless row_within_bounds(layout, new_row) && col_within_bounds(layout, new_col)

    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  # Check SE
  (1...layout.length).each do |offset|
    new_row, new_col = row + offset, col + offset
    break unless row_within_bounds(layout, new_row) && col_within_bounds(layout, new_col)

    occupied += 1 if layout[new_row][new_col] == '#'
    break if layout[new_row][new_col] != '.'
  end

  occupied
end

def get_next_state(layout, row, col)
  adjacent_occupied = count_adjacent_occupied(layout, row, col)
  case layout[row][col]
  when 'L'
    adjacent_occupied.zero? ? '#' : 'L'
  when '#'
    adjacent_occupied >= 5 ? 'L' : '#'
  else
    layout[row][col]
  end
end

def find_occupied(layout)
  loop do
    changes = 0
    layout = (0...layout.length).map do |row|
      (0...layout[0].length).map do |col|
        next_state = get_next_state(layout, row, col)
        changes += 1 if next_state != layout[row][col]
        next_state
      end
    end
    break if changes.zero?
  end
  layout.flatten.select { |ele| ele == '#' }.length
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.chars }
  find_occupied(input)
end
