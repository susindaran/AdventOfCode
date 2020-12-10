# frozen_string_literal: true

require_relative '../../aoc'

def find_differences(input)
  ratings = [0, input.sort!, input.last + 3].flatten

  ones = 0
  threes = 0
  index = 1
  until index >= ratings.length
    ones += 1 if ratings[index] - ratings[index - 1] == 1
    threes += 1 if ratings[index] - ratings[index - 1] == 3
    index += 1
  end

  ones * threes
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.to_i }
  find_differences(input)
end
