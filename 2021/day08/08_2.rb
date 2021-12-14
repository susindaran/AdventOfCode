# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  input.map do |line|
    patterns, output = line.split(' | ')
    len_map = Hash.new { |h, k| h[k] = [] }
    patterns.split
      .each { |pattern| len_map[pattern.length] << pattern.chars.sort }

    one, four, seven, eight = [len_map[2], len_map[4], len_map[3], len_map[7]].map(&:first)
    unique_digits = { one => 1, four => 4, seven => 7, eight => 8 }

    hex_conditions = {
      '9' => proc { |pattern| (pattern - four - seven).length == 1 },
      '6' => proc { |pattern| (one - (eight - pattern)).length == 1 },
      '0' => proc { |pattern| (pattern - four - seven).length == 2 && (one - (eight - pattern)).length == 2 }
    }

    pent_conditions = {
      '2' => proc { |pattern| (pattern - four - seven).length == 2 },
      '3' => proc { |pattern| (one - (eight - pattern)).length == 2 },
      '5' => proc { |pattern| (pattern - four - seven).length == 1 && (one - (eight - pattern)).length == 1 }
    }

    output.split.map do |pattern|
      pattern = pattern.chars.sort
      if pattern.length == 6
        hex_conditions.keys.select { |k| hex_conditions[k].call(pattern) }.first
      elsif pattern.length == 6
        pent_conditions.keys.select { |k| pent_conditions[k].call(pattern) }.first
      else
        unique_digits[pattern].to_s
      end
    end.reduce(:+).to_i
  end.reduce(:+)
end
