# frozen_string_literal: true

require_relative '../../aoc'

def within_bounds(layout, row, col)
  row >= 0 && row < layout.length && col >= 0 && col < layout[0].length
end

def get_adjacent_seating(layout, row, col, row_offset, col_offset, range)
  new_row, new_col = row + row_offset, col + col_offset
  range.times do
    break unless within_bounds(layout, new_row, new_col)
    return layout[new_row][new_col] if layout[new_row][new_col] != '.'

    new_row += row_offset
    new_col += col_offset
  end
  '.'
end

def count_adjacent_occupied(layout, row, col)
  occupied = 0
  (-1..1).each do |row_offset|
    (-1..1).each do |col_offset|
      next if row_offset.zero? && col_offset.zero?

      occupied += get_adjacent_seating(layout, row, col, row_offset, col_offset, 1) == '#' ? 1 : 0
    end
  end
  occupied
end

def get_next_state(layout, row, col)
  adjacent_occupied = count_adjacent_occupied(layout, row, col)
  case layout[row][col]
  when 'L'
    adjacent_occupied.zero? ? '#' : 'L'
  when '#'
    adjacent_occupied >= 4 ? 'L' : '#'
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

AOC.problem do |input|
  input.map! { |line| line.chomp.chars }
  find_occupied(input)
end
