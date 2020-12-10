# frozen_string_literal: true

require_relative '../../aoc'

def find_differences(input)
  ratings = [0, input.sort!, input.last + 3].flatten
  counts = ratings.each_cons(2).map { _2 - _1 }.tally
  counts[1] * counts[3]
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.to_i }
  find_differences(input)
end
