# frozen_string_literal: true

require_relative '../../aoc'

require 'set'

def get_count(groups)
  groups.map { |group| Set.new(group.chars).length }.reduce(&:+)
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input = input.map(&:chomp).join('#').split('##').map { |group| group.gsub('#', '') }
  get_count(input)
end
