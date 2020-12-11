# frozen_string_literal: true

require_relative '../../aoc'

def parse_seating(seating)
  seating.gsub!(/[FBRL]/, 'F' => '0', 'B' => '1', 'L' => 0, 'R' => '1')
  seating[0..6].to_i(2) * 8 + seating[7..9].to_i(2)
end

def highest_seat(seatings)
  seatings.map { |seating| parse_seating(seating) }.max
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map!(&:chomp)
  highest_seat(input)
end
