# frozen_string_literal: true

require_relative '../../aoc'

AOC.part1(read_lines: false) do |input|
  arrs = input.split("\n").map { |line| line.split('   ').map(&:to_i) }.transpose.map(&:sort!)
  arrs[0].zip(arrs[1]).map { |pair| (pair[0] - pair[1]).abs }.sum
end

AOC.part2(read_lines: false) do |input|
  arrs = input.split("\n").map { |line| line.split('   ').map(&:to_i) }.transpose

  lookup = arrs[1].tally
  arrs[0].map { |num| num * (lookup[num] || 0) }.sum
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 1_579_939
  raise unless part2_sol == 20_351_745
end
