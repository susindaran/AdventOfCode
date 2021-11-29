# frozen_string_literal: true

require_relative '../../aoc'

def calculate_score(deck)
  deck.each_with_index.map do |card, idx|
    card * (deck.length - idx)
  end.sum
end

def winning_score(decks)
  p1, p2 = decks

  until p1.length.zero? || p2.length.zero?
    p1_c = p1.shift
    p2_c = p2.shift

    if p1_c > p2_c
      p1.push p1_c
      p1.push p2_c
    else
      p2.push p2_c
      p2.push p1_c
    end
  end

  calculate_score(p1.length.zero? ? p2 : p1)
end

AOC.problem do |input|
  decks = input.join('').split("\n\n").map { |deck| deck.split("\n")[1..].map(&:to_i) }
  winning_score(decks)
end
