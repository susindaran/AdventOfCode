# frozen_string_literal: true

require_relative '../../aoc'

def solve(card_pk, door_pk)
  card_loops, val = 1, 7
  until val == card_pk
    card_loops += 1
    val = (val * 7) % 20_201_227
  end

  card_loops.times.inject(1) { |v, _| (v * door_pk) % 20_201_227 }
end

AOC.problem do |input|
  card_pk, door_pk = input.map(&:to_i)
  solve(card_pk, door_pk)
end
