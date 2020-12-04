# frozen_string_literal: true

require_relative '../../aoc'

def trees_encountered(input)
  slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  map = input.map(&:chars)
  cols = map[0].length

  total_trees = 1

  slopes.each do |slope|
    trees = 0

    row = 0
    col = 0
    while row < map.length
      trees += 1 if map[row][col] == '#'
      row += slope[1]
      col = (col + slope[0]) % cols
    end
    total_trees *= trees
  end

  total_trees
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input = input.map(&:chomp)
  trees_encountered(input)
end
