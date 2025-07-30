# frozen_string_literal: true

require_relative '../../aoc'

# {3=>1, 4=>3, 5=>6, 6=>7, 7=>6, 8=>3, 9=>1}
POSSIBLE_ROLLS = (1..3).to_a.repeated_permutation(3).to_a.map(&:sum).tally.freeze

class Solution
  def initialize
    @cache = {}
  end

  def dfs(w_score, b_score, w_pos, b_pos, w_turn)
    cache_hit = @cache[[w_score, b_score, w_pos, b_pos, w_turn]]
    return cache_hit unless cache_hit.nil?

    return [1, 0] if w_score >= 21
    return [0, 1] if b_score >= 21

    w_wins = 0
    b_wins = 0

    POSSIBLE_ROLLS.each do |sum, universes|
      if w_turn
        new_pos = ((w_pos + sum - 1) % 10) + 1
        op = dfs(w_score + new_pos, b_score, new_pos, b_pos, !w_turn)
      else
        new_pos = ((b_pos + sum - 1) % 10) + 1
        op = dfs(w_score, b_score + new_pos, w_pos, new_pos, !w_turn)
      end

      w_wins += (universes * op[0])
      b_wins += (universes * op[1])
    end

    @cache[[w_score, b_score, w_pos, b_pos, w_turn]] = [w_wins, b_wins]

    [w_wins, b_wins]
  end
end

AOC.problem do |input|
  white_pos = input[0].strip.split(': ')[1].to_i
  black_pos = input[1].strip.split(': ')[1].to_i

  w_wins, b_wins = Solution.new.dfs(0, 0, white_pos, black_pos, true)

  [w_wins, b_wins].max
end
