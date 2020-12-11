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
  (-1..1).each do |row_offset|
    new_row = row + row_offset
    next unless row_within_bounds(layout, new_row)

    (-1..1).each do |col_offset|
      new_col = col + col_offset
      next unless col_within_bounds(layout, new_col)
      next if row_offset.zero? && col_offset.zero?

      occupied += 1 if layout[new_row][new_col] == '#'
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

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.chars }
  find_occupied(input)
end
