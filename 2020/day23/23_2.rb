# frozen_string_literal: true

require_relative '../../aoc'

class Node
  attr_reader :val

  def initialize(val)
    @val = val
    @next_node = nil
  end

  def next=(node)
    @next_node = node
  end

  def next
    @next_node
  end
end

class LinkedList
  attr_reader :head

  def initialize(nums)
    nodes = nums.map { |num| Node.new(num) }

    # Link the nodes
    (0..nodes.length - 1).each do |idx|
      nodes[idx].next = nodes[idx + 1]
    end
    nodes.last.next = nodes.first

    @head = nodes[0]

    @map = nodes.map do |node|
      [node.val, node]
    end.to_h
  end

  def move_head
    @head = @head.next
  end

  def next_three
    first = @head.next
    last = first.next.next

    @head.next = last.next
    last.next = nil

    first
  end

  def find_node(val)
    @map[val]
  end
end

def play(list, max_val)
  current_cup = list.head
  picked_up = list.next_three
  picked_up_nums = [picked_up.val, picked_up.next.val, picked_up.next.next.val]

  # Find the target number
  target_num = (current_cup.val - 1) <= 0 ? max_val : (current_cup.val - 1)
  target_num = (target_num - 1) <= 0 ? max_val : (target_num - 1) while picked_up_nums.include?(target_num)

  # Look up the map to get the linkedlist node corresponding to the number
  destination_cup = list.find_node(target_num)

  # Attach the picked up cups next to the destination cup
  picked_up.next.next.next = destination_cup.next
  destination_cup.next = picked_up

  list.move_head
end

def solve(nums)
  nums += (nums.max + 1..1_000_000).to_a

  max_val = nums.max
  list = LinkedList.new(nums)

  10_000_000.times { play(list, max_val) }

  one = list.find_node(1)
  one.next.val * one.next.next.val
end

AOC.problem do |input|
  nums = input[0].chomp.chars.map(&:to_i)
  solve(nums)
end
