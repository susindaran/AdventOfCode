# frozen_string_literal: true

require_relative '../../aoc'

def trees_encountered(input)
  trees = 0
  map = input.map(&:chars)
  cols = map[0].length
  row = 0
  col = 0
  while row < map.length
    trees += 1 if map[row][col] == '#'
    row += 1
    col = (col + 3) % cols
  end
  trees
end

AOC.problem do |input|
  input = input.map(&:chomp)
  trees_encountered(input)
end
