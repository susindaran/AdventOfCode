# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem(read_lines: false) do |input|
  pattern, rules = input.split("\n\n")
  rules = rules.split("\n").map { |rule| rule.split(' -> ') }.to_h

  pairs = pattern.chars.each_cons(2).map(&:join).tally

  40.times do
    pairs = pairs.each_with_object({}) do |(pair, count), new_pairs|
      sub = rules[pair]
      left, right = pair[0] + sub, sub + pair[1]
      new_pairs[left] = new_pairs.fetch(left, 0) + count
      new_pairs[right] = new_pairs.fetch(right, 0) + count
    end
  end

  min, max = pairs.each_with_object({}) do |(pair, count), char_counts|
    char_counts[pair[0]] = char_counts.fetch(pair[0], 0) + count
    char_counts[pair[1]] = char_counts.fetch(pair[1], 0) + count
  end.values.minmax

  (max.to_f / 2).ceil - (min.to_f / 2).ceil
end
