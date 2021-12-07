# frozen_string_literal: true

require_relative '../../aoc'

def count(age, days, memory)
  return 1 if days.zero?
  return memory[age][days] if memory[age].key?(days)

  memory[age][days] = if age.zero?
                        count(6, days - 1, memory) + count(8, days - 1, memory)
                      else
                        count(age - 1, days - 1, memory)
                      end
end

AOC.problem do |input|
  fishes = input[0].split(',').map(&:to_i)
  memory = Hash.new { |h, k| h[k] = {} }

  fishes.sum do |fish|
    count(fish, 256, memory)
  end
end
