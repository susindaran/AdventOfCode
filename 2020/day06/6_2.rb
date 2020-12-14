# frozen_string_literal: true

require_relative '../../aoc'

require 'set'

def get_count(groups)
  groups.map do |group|
    group
      .map { |answer| Set.new(answer.chars) }
      .each_with_object(Hash.new(0)) { |chars, answer_map| chars.each { |char| answer_map[char] += 1 } }
      .select { |_, count| count == group.length }
      .length
  end.reduce(&:+)
end

AOC.problem do |input|
  input = input.join('').split("\n\n").map { |group| group.split("\n") }
  get_count(input)
end
