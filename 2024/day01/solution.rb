# frozen_string_literal: true

require_relative '../../aoc'

AOC.part1(read_lines: false) do |input|
  left, right = input.split("\n").map { |line| line.split('   ').map(&:to_i) }.transpose.map(&:sort!)
  left.zip(right).sum { |pair| (pair[0] - pair[1]).abs }
end

AOC.part2(read_lines: false) do |input|
  left, right = input.split("\n").map { |line| line.split('   ').map(&:to_i) }.transpose

  lookup = right.tally
  left.sum { |num| num * (lookup[num] || 0) }
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 1_579_939
  raise unless part2_sol == 20_351_745
end
