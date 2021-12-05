# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  lines = input.map { |line| line.split(' -> ').map { |str| str.split(',').map(&:to_i) } }
  count_map = Hash.new { |h, k| h[k] = 0 }
  enumerate = proc { |left, right| left <= right ? (left..right).to_a : left.downto(right).to_a }

  lines.each do |(left, right)|
    next if left[0] != right[0] && left[1] != right[1]

    xs, ys = enumerate.call(left[0], right[0]), enumerate.call(left[1], right[1])
    if xs.length < ys.length
      xs *= ys.length
    elsif ys.length < xs.length
      ys *= xs.length
    end
    [xs, ys].transpose.each { |(x, y)| count_map["#{x},#{y}"] += 1 }
  end

  count_map.values.count { |c| c > 1 }
end
