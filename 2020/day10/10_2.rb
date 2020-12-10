# frozen_string_literal: true

require_relative '../../aoc'

def find_combinations(input)
  input.sort!
  input.unshift(0)
  input.push(input.last + 3)

  counts = Array.new(input.length, 0)
  counts[0] = 1
  counts[1] = 1

  index = 2
  until index >= input.length
    counts[index] = counts[index - 1]
    counts[index] += counts[index - 2] if input[index] - input[index - 2] <= 3
    counts[index] += counts[index - 3] if input[index] - input[index - 3] <= 3

    index += 1
  end

  counts.last
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.to_i }
  find_combinations(input)
end
