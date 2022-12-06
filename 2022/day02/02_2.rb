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

# In keys:
# X - Lose
# Y - Draw
# Z - Win
choice = {
  'A' => { 'X' => 'Z', 'Y' => 'X', 'Z' => 'Y' },
  'B' => { 'X' => 'X', 'Y' => 'Y', 'Z' => 'Z' },
  'C' => { 'X' => 'Y', 'Y' => 'Z', 'Z' => 'X' }
}

AOC.problem do |rounds|
  rounds.map do |round|
    my_choice = choice[round[0]][round[2]]
    outcome[round[0] + my_choice] + value[my_choice]
  end.sum
end
