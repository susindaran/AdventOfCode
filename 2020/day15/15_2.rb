# frozen_string_literal: true

require_relative '../../aoc'

def get_spoken(starting_numbers)
  history = starting_numbers[0...starting_numbers.length].each_with_index.map do |number, index|
    [number, index + 1]
  end.to_h

  last_spoken = starting_numbers.last
  (starting_numbers.length + 1..30_000_000).each do |turn|
    speak = !history.key?(last_spoken) ? 0 : (turn - 1) - history[last_spoken]
    history[last_spoken] = turn - 1
    last_spoken = speak
  end

  last_spoken
end

AOC.problem do |input|
  starting_numbers = input[0].chomp.split(',').map(&:to_i)
  get_spoken(starting_numbers)
end
