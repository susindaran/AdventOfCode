# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  input.map(&:to_i).each_cons(2).count { |l, r| l < r }
end
