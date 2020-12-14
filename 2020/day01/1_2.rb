# frozen_string_literal: true

require_relative '../../aoc'

SUM_TOTAL = 2020
def find_sum_triplet(nums)
  map = {}
  nums.each do |num|
    map.each do |k, _|
      map[k] = false
      need = 2020 - (num + k)
      return num * k * need if map[need]

      map[k] = true
    end

    map[num] = true
  end

  0
end

AOC.problem do |input|
  input = input.map { |line| line.chomp.to_i }
  find_sum_triplet(input)
end
