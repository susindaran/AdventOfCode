# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem(read_lines: false) do |input|
  packet_size = 14
  input.chars.each_cons(packet_size).find_index { |part| part.uniq.size == packet_size } + packet_size
end
