# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem(read_lines: false) do |input|
  input.split("\n\n").map { |line| line.split("\n").map(&:to_i).sum }.max
end
