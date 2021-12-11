# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  nums = input[0].split(',').map(&:to_i)
  min, max = nums.min, nums.max
  (min..max).map do |res|
    nums.sum { |num| dist = (res - num).abs; (dist * (dist + 1)) / 2 }
  end.min
end
