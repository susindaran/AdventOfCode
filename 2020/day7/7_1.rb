# frozen_string_literal: true

require_relative '../../aoc'

require 'set'

class Bag
  attr_reader :color, :contents

  def initialize(color)
    @color = color
    @contents = []
  end

  def add_content(bag)
    @contents << bag
  end
end

def get_bag_by_color(bags, color)
  bags[color] = Bag.new(color) unless bags.key?(color)
  bags[color]
end

def parse_rule(bag_colors, rule)
  rule.split(' contain ')[0]
end

def color_possibilities(rules)
  bag_colors = Hash.new
  rules = rules.map do |rule|
    parse_rule(bag_colors, rule)
  end

  Set.new(rules).length
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  color_possibilities(input.map(&:chomp))
end
