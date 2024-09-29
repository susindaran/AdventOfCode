# frozen_string_literal: true

require_relative '../../aoc'

class Node
  attr_accessor :val, :left, :right, :prev, :next

  def initialize(val, left, right)
    @val = val
    @left = left
    @right = right

    @prev = @next = nil
  end

  def left_most_leaf
    return self if leaf? || @left.nil?
    @left.left_most_leaf
  end

  def right_most_leaf
    return self if leaf? || @right.nil?
    @right.right_most_leaf
  end

  def leaf?
    !@val.nil?
  end

  def pair?
    @left&.leaf? && @right&.leaf?
  end

  def to_s
    leaf? ? @val : "[#{@left.to_s},#{@right.to_s}]"
  end

  def magnitude
    @val.nil? ? @left&.magnitude * 3 + @right&.magnitude * 2 : @val
  end
end

def parse(input)
  stack = []
  num_building = false
  num = ''
  input.chars.each do |char|
    if char == '['
      stack << char
    elsif char == ','
      if num_building
        stack << Node.new(num.to_i, nil, nil)
        num_building = false
        num = ''
      end
    elsif char == ']'
      if num_building
        stack << Node.new(num.to_i, nil, nil)
        num_building = false
        num = ''
      end
      right = stack.pop
      left = stack.pop

      # Popping the matching '[' of this pair
      stack.pop

      left.right_most_leaf.next = right.left_most_leaf
      right.left_most_leaf.prev = left.right_most_leaf

      stack << Node.new(nil, left, right)
    else
      num_building = true
      num += char
    end
  end

  stack.pop
end

def explode(node, level)
  return false if node.nil?

  if level >= 5 && node.pair?
    unless node.left.prev.nil?
      node.left.prev.val += node.left.val
      node.prev = node.left.prev
      node.prev.next = node
    end

    unless node.right.next.nil?
      node.right.next.val += node.right.val
      node.next = node.right.next
      node.next.prev = node
    end

    node.val = 0
    node.left = node.right = nil

    return true
  end

  explode(node.left, level + 1) || explode(node.right, level + 1)
end

def create_split_node(val)
  left = Node.new((val / 2.0).floor, nil, nil)
  right = Node.new((val / 2.0).ceil, nil, nil)

  left.next = right
  right.prev = left

  Node.new(nil, left, right)
end

def split(node)
  return false if node.nil?

  if node.left&.leaf? && node.left.val >= 10
    new_node = create_split_node(node.left.val)

    # prev_node <-  node.left   -> next_node
    # prev_node <- [half, half] -> next_node
    prev_node = node.left.prev
    new_node.left.prev = prev_node
    prev_node.next = new_node.left unless prev_node.nil?

    next_node = node.left.next
    new_node.right.next = next_node
    next_node.prev = new_node.right unless next_node.nil?

    node.left = new_node
    return true
  end

  return true if split(node.left)

  if node.right&.leaf? && node.right.val >= 10
    new_node = create_split_node(node.right.val)

    prev_node = node.right.prev
    new_node.left.prev = prev_node
    prev_node.next = new_node.left unless prev_node.nil?

    next_node = node.right.next
    new_node.right.next = next_node
    next_node.prev = new_node.right unless next_node.nil?

    node.right = new_node
    return true
  end

  split(node.right)
end

def reduce(node)
  while true
    next if explode(node, 1)
    next if split(node)

    break
  end
  node
end

def add(left, right)
  left.right_most_leaf.next = right.left_most_leaf
  right.left_most_leaf.prev = left.right_most_leaf
  Node.new(nil, left, right)
end

AOC.problem do |input|
  nodes = input.map { |i| parse(i) }

  nodes[1..].reduce(nodes[0]) { |sum, node| reduce(add(sum, node)) }.magnitude
end
