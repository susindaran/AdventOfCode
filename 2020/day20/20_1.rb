# frozen_string_literal: true

require_relative '../../aoc'
require 'set'

class Tile
  attr_reader :id, :borders, :neighbours

  def initialize(id, lines)
    @id = id
    @neighbours = Set.new

    @borders = [lines[0]]

    last_col = lines[0].length - 1
    @borders << (0...lines.length).map { |row| lines[row][last_col] }.join('')

    @borders << lines.last
    @borders << (lines[0].length - 1).downto(0).map { |row| lines[row][0] }.join('')
  end

  def add(neighbour)
    @neighbours.add(neighbour)
  end

  def to_s
    "#{@id} => #{@borders}"
  end
end

def solve(tiles)
  m = {}
  tiles.each do |tile|
    tile.borders.each do |border|
      m[border] = [] unless m.key?(border)
      m[border] << tile

      reversed = border.reverse
      m[reversed] = [] unless m.key?(reversed)
      m[reversed] << tile
    end
  end

  m.each do |_, sharing|
    next if sharing.length <= 1

    sharing.each do |tile|
      (sharing - [tile]).each do |other|
        tile.add(other.id)
      end
    end
  end

  tiles.select { |tile| tile.neighbours.length == 2 }.reduce(1) { |prod, tile| prod * tile.id.to_i }
end

AOC.problem do |input|
  tiles = input.join('').split("\n\n")
  tiles = tiles.map do |tile|
    lines = tile.split("\n")
    id = lines[0].split(' ')[1].gsub(':', '')
    Tile.new(id, lines[1..])
  end

  solve(tiles)
end
