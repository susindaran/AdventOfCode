# frozen_string_literal: true

require_relative '../../aoc'

def find_differences(input)
  input.sort!
  input.unshift(0)
  input.push(input.last + 3)

  ones = 0
  threes = 0
  index = 1
  until index >= input.length
    ones += 1 if input[index] - input[index - 1] == 1
    threes += 1 if input[index] - input[index - 1] == 3
    index += 1
  end

  ones * threes
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.to_i }
  find_differences(input)
end
