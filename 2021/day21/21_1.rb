# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem do |input|
  white_pos = input[0].strip.split(': ')[1].to_i - 1
  black_pos = input[1].strip.split(': ')[1].to_i - 1

  white_score, black_score = 0, 0
  white_turn = true
  die = 1
  turns = 0

  loop do
    score = (die * 3) + 3
    die += 3

    if white_turn
      white_pos = (white_pos + score) % 10
      white_score += (white_pos + 1)
    else
      black_pos = (black_pos + score) % 10
      black_score += (black_pos + 1)
    end

    white_turn = !white_turn
    turns += 3

    die -= 100 if die > 100
    break if white_score >= 1000 || black_score >= 1000
  end

  turns * (white_score >= 1000 ? black_score : white_score)
end
