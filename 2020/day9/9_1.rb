# frozen_string_literal: true

require_relative '../../aoc'

def find_weakness(input, preamble_count)
  preamble = input[0...preamble_count]

  index = preamble_count
  until index >= input.length
    element = input[index]
    pair = preamble.permutation(2).find { |a, b| a + b == element }
    break if pair.nil?

    preamble.shift
    preamble.push element
    index += 1
  end

  input[index]
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.to_i }
  preamble_count = 25
  find_weakness(input, preamble_count)
end
