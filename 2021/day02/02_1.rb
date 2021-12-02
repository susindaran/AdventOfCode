# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  result = input.map(&:split).each_with_object([0, 0]) do |(dir, val), counter|
    val = val.to_i
    case dir
    when 'forward' then counter[0] += val
    when 'down' then counter[1] += val
    when 'up' then counter[1] -= val
    end
    counter
  end
  result[0] * result[1]
end
