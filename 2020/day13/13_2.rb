# frozen_string_literal: true

require_relative '../../aoc'

# Example
# 5, x, 6
#
# Step starts with 1
#
# The first id departs in 0, 5, 10, 15, 20, 25, 30...
# The second id (6) has an offset of 2 here.
def find_earliest(ids)
  time = ids.first[0]
  step = 1

  ids.each do |id, offset|
    time += step until ((time + offset) % id).zero?
    step *= id
  end

  time
end

AOC.problem do |input|
  input = input.map(&:chomp)[1].split(',')

  ids = input.each_with_index.filter_map do |id, idx|
    next if id == 'x'

    [id.to_i, idx]
  end

  find_earliest(ids)
end
