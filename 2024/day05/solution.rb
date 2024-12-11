# frozen_string_literal: true

require_relative '../../aoc'

def parse_input(input)
  rules, updates = input.split("\n\n")
  rules = rules.split("\n").map { _1.split('|') }
  updates = updates.split("\n").map { _1.split(',') }

  pages = Hash.new { |hash, k| hash[k] = { before: [], after: [] } }
  rules.each do |left, right|
    pages[left][:after] << right
    pages[right][:before] << left
  end

  [pages, updates]
end

def find_updates(pages, updates, valid: true)
  blk = proc do |update|
    update.each_with_index.all? do |page, idx|
      # Check if any of the pages that's supposed to come after, comes before the current one in this update
      (pages[page][:after] & update[...idx]).empty?
    end
  end

  valid ? updates.select(&blk) : updates.reject(&blk)
end

def reorder_update(update, pages)
  return update if update.nil? || update.empty? || update.size <= 1

  page = pages[update[0]]
  left = page[:before].intersection(update[1..])
  right = page[:after].intersection(update[1..])

  reorder_update(left, pages) + [update[0]] + reorder_update(right, pages)
end

AOC.part1(read_lines: false) do |input|
  pages, updates = parse_input(input)
  find_updates(pages, updates).sum { _1[_1.size / 2].to_i }
end

AOC.part2(read_lines: false) do |input|
  pages, updates = parse_input(input)
  find_updates(pages, updates, valid: false).map { reorder_update(_1, pages) }.sum { _1[_1.size / 2].to_i }
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 4_609
  raise unless part2_sol == 5_723
end
