# frozen_string_literal: true

require_relative '../../aoc'

SUM_TOTAL = 2020
def find_sum_pair(nums)
  map = {}
  nums.each do |num|
    return num * (SUM_TOTAL - num) if map[SUM_TOTAL - num]

    map[num] = true
  end

  0
end

AOC.problem do |input|
  input = input.map { |line| line.chomp.to_i }
  find_sum_pair(input)
end
