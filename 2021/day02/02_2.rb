# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  result = input.map(&:split).each_with_object([0, 0, 0]) do |(dir, val), counter|
    val = val.to_i
    case dir
    when 'forward' then counter[0] += val; counter[1] += (val * counter[2])
    when 'down' then counter[2] += val
    when 'up' then counter[2] -= val
    end
    counter
  end
  result[0] * result[1]
end
