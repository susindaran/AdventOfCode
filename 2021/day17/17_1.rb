# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem(read_lines: false) do |input|
  puts input
  regex = /: x=(\d+)..(\d+), y=([-0-9]+)..([-0-9]+)/
  match = regex.match(input)
  y_start, y_end = match[3].to_i, match[4].to_i

  lowest = [y_start, y_end].min.abs
  (lowest * (lowest - 1)) / 2
end
