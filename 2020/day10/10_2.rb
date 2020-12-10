# frozen_string_literal: true

require_relative '../../aoc'

def find_combinations(input)
  ratings = [0, input.sort!, input.last + 3].flatten
  counts = [1, Array.new(ratings.length - 1, 0)].flatten

  (1...ratings.length).each do |index|
    counts[index] = (1..3).filter_map do |offset|
      next if (index - offset).negative?
      counts[index - offset] if ratings[index] - ratings[index - offset] <= 3
    end.sum
  end

  counts.last
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.to_i }
  find_combinations(input)
end
