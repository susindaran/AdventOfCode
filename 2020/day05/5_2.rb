# frozen_string_literal: true

require_relative '../../aoc'

def parse_seating(seating)
  seating.gsub!(/[FBRL]/, 'F' => '0', 'B' => '1', 'L' => 0, 'R' => '1')
  seating[0..6].to_i(2) * 8 + seating[7..9].to_i(2)
end

def missing_seat_id(seatings)
  seat_ids = seatings.map { |seating| parse_seating(seating) }
  low = seat_ids.min
  high = seat_ids.max
  ((high - low + 1) * (low + high) / 2) - seat_ids.sum
end

AOC.problem do |input|
  input.map!(&:chomp)
  missing_seat_id(input)
end
