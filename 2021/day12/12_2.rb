# frozen_string_literal: true

require_relative '../../aoc'

class Node
  attr_reader :name, :small
  attr_accessor :neighbours, :visit_count

  def initialize(name)
    @name = name
    @small = (@name == @name.downcase)
    @visit_count = 0
    @neighbours = []
  end

  def visit_limit?
    @small && @visit_count.positive?
  end

  def to_s
    "#{@name} -> #{@neighbours.map(&:name).join(', ')}"
  end
end

def traverse(node, visited)
  return 0 if node.nil? || (node.visit_limit? && !visited.empty?)
  return 1 if node.name == 'end'

  node.visit_count += 1

  updated_visited = visited + (node.visit_limit? && node.visit_count == 2 ? [node.name] : [])
  sum = node.neighbours.sum { |neighbour| traverse(neighbour, updated_visited) }

  node.visit_count -= 1
  sum
end

AOC.problem do |input|
  nodes = {}
  input.map do |line|
    path = line.strip.split('-')

    # Create node objects if it doesn't already exists
    path.each { |node_name| nodes[node_name] = Node.new(node_name) unless nodes.include?(node_name) }

    # Link the other node as neighbour
    # Dont add 'start' to any node's neighbours as we don't ever want to visit start again
    nodes[path[0]].neighbours << nodes[path[1]] unless path[1] == 'start'
    nodes[path[1]].neighbours << nodes[path[0]] unless path[0] == 'start'
  end

  traverse(nodes['start'], [])
end
