# frozen_string_literal: true

require_relative '../../aoc'

require 'set'

def get_count(groups)
  groups.map { |group| Set.new(group.chars).length }.reduce(&:+)
end

AOC.problem do |input|
  input = input.map(&:chomp).join('#').split('##').map { |group| group.gsub('#', '') }
  get_count(input)
end
