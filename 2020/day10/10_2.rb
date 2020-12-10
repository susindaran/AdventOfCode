# frozen_string_literal: true

require_relative '../../aoc'

def find_combinations(input)
  ratings = [0, input.sort!, input.last + 3].flatten
  counts = [1, 1, Array.new(ratings.length - 2, 0)].flatten

  index = 2
  until index >= ratings.length
    counts[index] = counts[index - 1]
    counts[index] += counts[index - 2] if ratings[index] - ratings[index - 2] <= 3
    counts[index] += counts[index - 3] if ratings[index] - ratings[index - 3] <= 3

    index += 1
  end

  counts.last
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.to_i }
  find_combinations(input)
end
