# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  nums = input[0].split(',').map(&:to_i)
  medoid = nums.sort[nums.length / 2]
  nums.sum { |num| (medoid - num).abs }
end
