# frozen_string_literal: true

require_relative '../../aoc'

def get_row(seating)
  seating[0..6].reverse.chars.each_with_index.inject(0) do |row, (dir, index)|
    row | ((dir == 'F' ? 0 : 1) << index)
  end
end

def get_column(seating)
  seating[7..9].reverse.chars.each_with_index.inject(0) do |col, (dir, index)|
    col | ((dir == 'R' ? 1 : 0) << index)
  end
end

def parse_seating(seating)
  get_row(seating) * 8 + get_column(seating)
end

def highest_seat(seatings)
  seatings.map do |seating|
    parse_seating(seating)
  end.max
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map!(&:chomp)
  highest_seat(input)
end
