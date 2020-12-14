# frozen_string_literal: true

require_relative '../../aoc'

# `step` starts with 1, `time`` starts with 0
# We take each ID and try to find the `time` such that time + ID's offset' is
# divisible by the ID, incrementing `time` by `step`. After finding that `time`,
# `step` is multiplied with the id to get the new `step`.
#
# Example
# 5, x, 6, 7
#
# step = 1, time = 0
# first ID has offset of 0, so 0(time)+0(offset) is divisible by 5
#
# Now step = 5 (1 * 5)
# Starting from 0, increment `time` by 5 (step) until we find a time such that
# (time + 2) % 6 == 0
# in this case `time` is 10.
# Here (10 + 0) % 5 == 0 AND (10 + 2) % 6 == 0
#
# Now step becomes 5 * 6 = 30
# What it means is that every 30th number from 10 is divisible by 5 and every
# 32nd number from 10 is divisble by 6. So whatever our next requirement is,
# we have to find the next time by only incrementing by 30 because otherwise
# we can't continue to satisfy the first two requirement we have satisfied.
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
