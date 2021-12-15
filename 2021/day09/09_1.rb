# frozen_string_literal: true

require_relative '../../aoc'

DIRS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

AOC.problem do |input|
  mat = input.each_with_index.map do |line, row|
    # from "4567" to {[0, 0]=>4, [0, 1]=>5, [0, 2]=>6, [0, 3]=>7}
    line.strip.chars.each_with_index.map { |e, col| [[row, col], e.to_i] }.to_h
  end.reduce(:merge)

  (0...input.length).sum do |row|
    (0...input[row].strip.length).sum do |col|
      h = mat[[row, col]]
      DIRS.all? { |dir| h < (mat[[row + dir[0], col + dir[1]]] || 10) } ? h + 1 : 0
    end
  end
end
