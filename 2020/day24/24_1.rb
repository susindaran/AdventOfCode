# frozen_string_literal: true

require_relative '../../aoc'

DIR_TO_OFFSET_MAP = {
  'e' => [1, 0],
  'se' => [0, -1],
  'sw' => [-1, -1],
  'w' => [-1, 0],
  'nw' => [0, 1],
  'ne' => [1, 1]
}.freeze

def parse_directions(directions)
  directions.each.inject([0, 0]) do |tile, direction|
    DIR_TO_OFFSET_MAP[direction].zip(tile).map { |actual, offset| actual + offset }
  end
end

def solve(tile_directions)
  tiles = {}

  tile_directions.each do |directions|
    tile = parse_directions(directions)
    # true means black
    tiles[tile] = !tiles.fetch(tile, false)
  end

  tiles.count { |_, flipped| flipped }
end

AOC.problem do |input|
  tile_directions = input.map do |line|
    line.strip.chars.each_with_object([]) do |char, directions|
      if !directions.length.zero? && %w[n s].include?(directions[-1])
        directions[-1] += char
      else
        directions << char
      end
    end
  end

  solve(tile_directions)
end
