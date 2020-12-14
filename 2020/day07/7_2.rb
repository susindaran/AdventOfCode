# frozen_string_literal: true

require_relative '../../aoc'

require 'set'

class Bag
  attr_reader :color, :contents, :parents, :visited

  def initialize(color)
    @color = color
    @contents = []
    @parents = []
    @visited = false
  end

  def add_content(bag, count)
    @contents << { bag: bag, count: count }
  end

  def add_parent(bag)
    @parents << bag
  end

  def visit
    @visited = true
  end
end

def get_bag_by_color(bags, color)
  bags[color] = Bag.new(color) unless bags.key?(color)
  bags[color]
end

def parse_rule(bags, rule)
  # Example rules:
  # dark maroon bags contain 2 striped silver bags, 4 mirrored maroon bags, 5 shiny gold bags, 1 dotted gold bag.
  # wavy yellow bags contain no other bags.

  rule = rule[0...rule.length - 1]
  rule_parts = rule.split(' contain ')
  parent_bag = get_bag_by_color(bags, rule_parts[0].match('^([a-z ]+) bags$')[1])

  return if rule_parts[1] == 'no other bags'

  rule_parts[1].split(', ').each do |child_bag_rule|
    match = child_bag_rule.match('^([0-9]+) ([a-z ]+) bag(s?)$')

    child_bag = get_bag_by_color(bags, match[2])

    parent_bag.add_content(child_bag, match[1].to_i)
    child_bag.add_parent(parent_bag)
  end
end

def get_total_child_bags(bag)
  return 1 if bag.contents.empty?

  total_child_bags = bag.contents.reduce(0) do |sum, content|
    sum + (content[:count] * get_total_child_bags(content[:bag]))
  end

  total_child_bags + 1
end

def color_possibilities(rules)
  bags = rules.each_with_object({}) do |rule, map|
    parse_rule(map, rule)
  end

  get_total_child_bags(get_bag_by_color(bags, 'shiny gold')) - 1
end

AOC.problem do |input|
  color_possibilities(input.map(&:chomp))
end
