# frozen_string_literal: true

require_relative '../../aoc'

def to_ascii(char)
  ord = char.ord
  if ord < 97
    ord - 38
  else
    ord - 96
  end
end

AOC.problem(read_lines: false) do |input|
  input.split("\n").each_slice(3).sum { |group| to_ascii(group.map(&:chars).reduce(&:&).first) }
end
