# frozen_string_literal: true

require_relative '../../aoc'

REGEX = /mul\((?<left>\d{1,3}),(?<right>\d{1,3})\)/

AOC.part1(read_lines: false) do |input|
  input.scan(REGEX).sum { |l, r| l.to_i * r.to_i }
end

AOC.part2(read_lines: false) do |input|
  input
    .split('do()')
    .flat_map { |part| part.split("don't()")[0].scan(REGEX) }
    .sum { |l, r| l.to_i * r.to_i }
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 189_527_826
  raise unless part2_sol == 63_013_756
end
