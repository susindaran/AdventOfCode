# frozen_string_literal: true

require_relative '../../aoc'

def is_valid_password(input)
  input.filter do |line|
    policy, password = line.split(': ')
    char_count = password.chars.each_with_object(Hash.new(0)) do |char, map|
      map[char] += 1
    end

    limits, policy_char = policy.split(' ')
    min, max = limits.split('-').map(&:to_i)
    char_count[policy_char] >= min && char_count[policy_char] <= max
  end.size
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input = input.map(&:chomp)
  is_valid_password(input)
end
