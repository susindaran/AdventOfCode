# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem(read_lines: false) do |input|
  input.split("\n").sum do |line|
    ranges = line.split(',').map do |range|
      first, last = range.split('-').map(&:to_i)
      first..last
    end
    ranges[0].cover?(ranges[1].first) || ranges[1].cover?(ranges[0].first) ? 1 : 0
  end
end
