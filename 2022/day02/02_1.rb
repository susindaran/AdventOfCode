# frozen_string_literal: true

require_relative '../../aoc'

value = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}

outcome = {
  'AZ' => 0, 'BX' => 0, 'CY' => 0, # Lose
  'AX' => 3, 'BY' => 3, 'CZ' => 3, # Draw
  'AY' => 6, 'BZ' => 6, 'CX' => 6  # Win
}

AOC.problem do |rounds|
  rounds.map { |round| outcome[round[0] + round[2]] + value[round[2]] }.sum
end
