# frozen_string_literal: true

require_relative '../../aoc'

def filter_numbers(numbers, idx, condition)
  ones = numbers.map { |num| num[idx].to_i }.reduce(:+)
  sig_bit = condition.call(ones, numbers.length - ones)
  numbers.select { |num| num[idx] == sig_bit }
end

AOC.problem do |input|
  numbers = input.map { |line| line.strip.chars }

  most = proc { |ones, zeroes| ones >= zeroes ? '1' : '0' }
  least = proc { |ones, zeroes| ones >= zeroes ? '0' : '1' }

  o2, co2 = numbers, numbers
  numbers.first.length.times do |idx|
    o2 = filter_numbers(o2, idx, most) if o2.length > 1
    co2 = filter_numbers(co2, idx, least) if co2.length > 1
  end

  o2.first.reduce(:+).to_i(2) * co2.first.reduce(:+).to_i(2)
end
