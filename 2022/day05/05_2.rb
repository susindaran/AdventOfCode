# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem(read_lines: false) do |input|
  map_str, movements = input.split("\n\n")

  stacks = {}
  map_str.split("\n")[...-1].each do |line|
    line.chars.each_slice(4).each_with_index.map do |slice, idx|
      stacks[idx] ||= []
      stacks[idx].unshift(slice[1]) unless slice[1] == ' '
    end
  end

  movements.split("\n").each do |move|
    count, from, to = move.match(/move (\d+) from (\d+) to (\d+)/).captures
    stacks[to.to_i - 1] += stacks[from.to_i - 1].pop(count.to_i)
  end

  stacks.length.times.map { |idx| stacks[idx].last }.reduce(&:+)
end
