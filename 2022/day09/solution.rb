# frozen_string_literal: true

require_relative '../../aoc'
require 'set'

class Coordinate
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_a
    [@x, @y]
  end

  def add(other)
    @x += other.x
    @y += other.y
  end

  def distant_by?(other, threshold)
    (@x - other.x).abs >= threshold || (@y - other.y).abs >= threshold
  end
end

DIRS = {
  'R' => Coordinate.new(1, 0),
  'L' => Coordinate.new(-1, 0),
  'U' => Coordinate.new(0, 1),
  'D' => Coordinate.new(0, -1)
}.freeze

def solve(input, knot_count)
  movements = input.split("\n").map do |line|
    dir, units = line.split(' ')
    [DIRS[dir], units.to_i]
  end

  knots = Array.new(knot_count) { Coordinate.new(0, 0) }
  tail_visited = Set.new

  movements.each do |dir, units|
    units.times do
      knots.first.add dir
      knots.each_cons(2) do |ahead, behind|
        behind.add Coordinate.new(ahead.x <=> behind.x, ahead.y <=> behind.y) if ahead.distant_by?(behind, 2)
      end
      tail_visited.add knots.last.to_a
    end
  end

  tail_visited.size
end
