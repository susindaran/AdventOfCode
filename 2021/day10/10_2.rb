# frozen_string_literal: true

require_relative '../../aoc'

SCORES = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze

PAIRS = {
  ')' => '(',
  ']' => '[',
  '}' => '{',
  '>' => '<'
}.freeze

INVERTED_PAIRS = PAIRS.invert.freeze
OPENERS = PAIRS.values.freeze

AOC.problem do |input|
  res = input.map do |line|
    stack = []
    line.strip.chars.each do |char|
      if OPENERS.include?(char)
        stack.push(char)
        next
      end

      if stack.last == PAIRS[char]
        stack.pop
        next
      end

      # Corrupted line
      unless stack.empty?
        stack = []
        break
      end
    end

    stack.reverse.reduce(0) { |total_score, char| (total_score * 5) + SCORES[INVERTED_PAIRS[char]] }
  end

  res = res.reject(&:zero?).sort
  res[res.length / 2]
end
