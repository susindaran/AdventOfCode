# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  input.map { |line| line.strip.chars }.transpose.map do |bits|
    sum = bits.map(&:to_i).reduce(:+)
    sum <= (bits.length / 2) ? ['0', '1'] : ['1', '0']
  end.transpose.map { |x| x.reduce(:+).to_i(2) }.reduce(:*)
end
