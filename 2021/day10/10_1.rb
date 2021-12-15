# frozen_string_literal: true

require_relative '../../aoc'

SCORES = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}.freeze

PAIRS = {
  ')' => '(',
  ']' => '[',
  '}' => '{',
  '>' => '<'
}.freeze

OPENERS = PAIRS.values

AOC.problem do |input|
  input.sum do |line|
    stack = []
    score = 0
    line.strip.chars.each do |char|
      if OPENERS.include?(char)
        stack.push(char)
        next
      end

      break if stack.empty?

      if stack.last == PAIRS[char]
        stack.pop
      else
        score = SCORES[char]
        break
      end
    end
    score
  end
end
