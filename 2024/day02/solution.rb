# frozen_string_literal: true

require_relative '../../aoc'

def safe?(report)
  diffs = report.each_cons(2).map { |x, y| y - x }
  return false if !diffs.all?(&:positive?) && !diffs.all?(&:negative?)

  diffs.none? { |diff| diff.abs < 1 || diff.abs > 3 }
end

AOC.part1(read_lines: false) do |input|
  reports = input.split("\n").map { |line| line.split.map(&:to_i) }
  reports.count { |report| safe?(report) }
end

AOC.part2(read_lines: false) do |input|
  reports = input.split("\n").map { |line| line.split.map(&:to_i) }
  reports.count do |report|
    # If the entire report is not safe, try removing one element at a time and check for safety
    safe?(report) || (0...report.size).any? { |idx| safe?(report[0...idx] + report[idx + 1...report.size]) }
  end
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 246
  raise unless part2_sol == 318
end
