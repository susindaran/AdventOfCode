# frozen_string_literal: true

require_relative '../../aoc'

def is_valid_password(input)
  input.filter do |line|
    policy, password = line.split(': ')

    limits, policy_char = policy.split(' ')
    left, right = limits.split('-').map(&:to_i)
    (password[left - 1] == policy_char) ^ (password[right - 1] == policy_char)
  end.size
end

AOC.problem do |input|
  input = input.map(&:chomp)
  is_valid_password(input)
end
