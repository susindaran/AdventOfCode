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

AOC.problem(read_lines: false) do |sacks|
  sacks.split("\n").sum do |sack|
    items = sack.chars
    first, second = items.each_slice(items.length / 2).to_a
    to_ascii((first & second).first)
  end
end
