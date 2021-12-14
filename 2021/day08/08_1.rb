# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  unique_sizes = [2, 4, 3, 7]
  input.map { |line| line.split(' | ')[1] }.flat_map(&:split).count { |w| unique_sizes.include?(w.length) }
end
