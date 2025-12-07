# frozen_string_literal: true

require_relative '../../aoc'

class Ranges
  def initialize
    @ranges = []
  end

  # ranges = [[left, right], [left, right]..]
  def add_all(ranges)
    ranges.sort_by { |r| r[0] }.each { |r| add(r[0], r[1]) }
  end

  # Make sure to add ranges in increasing order of left value
  def add(left, right)
    if @ranges.last.nil? || @ranges.last[1] < left
      @ranges << [left, right]
    else
      @ranges.last[1] = [@ranges.last[1], right].max
    end
  end

  def in_range?(val)
    @ranges.any? { |left, right| left <= val && val <= right }
  end

  def total_length
    @ranges.sum { |left, right| right - left + 1 }
  end
end

AOC.part1(read_lines: false) do |input|
  ranges, ids = input.split("\n\n").map { |x| x.split("\n") }

  rr = Ranges.new
  rr.add_all(ranges.map { |r| r.split('-').map(&:to_i) })

  ids.sum { |id| rr.in_range?(id.to_i) ? 1 : 0 }
end

AOC.part2(read_lines: false) do |input|
  ranges, _ = input.split("\n\n").map { |x| x.split("\n") }

  rr = Ranges.new
  rr.add_all(ranges.map { |r| r.split('-').map(&:to_i) })

  rr.total_length
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 577
  raise unless part2_sol == 350513176552950
end
