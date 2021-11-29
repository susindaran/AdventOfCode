# frozen_string_literal: true

require_relative '../../aoc'

def calculate_score(deck)
  deck.each_with_index.map { |card, idx| card * (deck.length - idx) }.sum
end

def who_won?(p0_c, p1_c, p0, p1)
  if p0.length >= p0_c && p1.length >= p1_c
    winner([p0[0...p0_c].dup, p1[0...p1_c].dup])[:player]
  else
    p0_c > p1_c ? 0 : 1
  end
end

def winner(decks)
  p0, p1 = decks
  history = []
  won_by_inf = false

  until p0.length.zero? || p1.length.zero?
    if history.include?([p0, p1])
      won_by_inf = true
      break
    end

    history << [p0.dup, p1.dup]

    p0_c = p0.shift
    p1_c = p1.shift

    if who_won?(p0_c, p1_c, p0, p1).zero?
      p0.push p0_c
      p0.push p1_c
    else
      p1.push p1_c
      p1.push p0_c
    end
  end

  return { player: 0, deck: p0 } if won_by_inf

  { player: p0.length.zero? ? 1 : 0, deck: p0.length.zero? ? p1 : p0 }
end

AOC.problem do |input|
  decks = input.join('').split("\n\n").map { |deck| deck.split("\n")[1..].map(&:to_i) }
  win = winner(decks)
  calculate_score(win[:deck])
end
