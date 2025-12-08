# frozen_string_literal: true

require_relative '../../aoc'

AOC.part1(read_lines: true) do |input|
  input = input.map { |line| line.gsub(/ +/, ' ').split(' ') }

  problems = input[0...input.size - 1].map { |arr| arr.map(&:to_i) }.transpose
  ops = input[-1]

  problems.each_with_index.sum { |nums, idx| nums.reduce(&ops[idx].to_sym) }
end

AOC.part2(read_lines: true) do |input|
  ops = input[-1].gsub(/ +/, ' ').split(' ')

  problems = input[0...input.size - 1].map(&:chars)
  max_len = problems.map { |line| line.size }.max

  # Adding extra [' '] to be begining here because `slice_before` operation below
  # includes the delimiter to the sub-arrays except the first one. So adding the extra
  # delimiter at the beginning will make it so that the first sub-array will also have
  # the delimiter in it.
  problems = [' '] + problems
               # Fill to make everything same length
               .map { |line| line + ([' '] * (max_len - line.size)) }
               .transpose
               .map { |line| line.join('') }

  # Split into sub arrays by delimiting on empty string
  # which is the column that separated the problems in input
  problems = problems.slice_before { |x| x.strip.empty? }.to_a

  problems.each_with_index.sum do |nums, idx|
    nums[1..].map(&:to_i).reduce(&ops[idx].to_sym)
  end
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 4878670269096
  raise unless part2_sol == 8674740488592
end
