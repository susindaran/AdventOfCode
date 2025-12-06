# frozen_string_literal: true

require_relative '../../aoc'

require 'debug'

AOC.part1(read_lines: true) do |input|
  sum = 0
  input.each do |line|
    x, y = 0, 1
    max = 0
    bats = line.chars.map(&:to_i)

    while (x <= y and y < bats.size)
      joltage = (bats[x] * 10) + bats[y]
      max = [max, joltage].max

      x = y if bats[x] <= bats[y]
      y += 1
    end
    sum += max
  end

  sum
end

def dp(bats)
  arr = Array.new(bats.size) { Hash.new }

  arr[bats.size - 1][1] = bats[-1]

  pos = bats.size - 2

  while pos >= 0
    12.downto(1).each do |s|
      if s == 1
        arr[pos][s] = [bats[pos], arr[pos + 1][s]].max
      elsif !arr[pos + 1][s - 1].nil?
        arr[pos][s] = [(bats[pos] * (10**(s - 1))) + arr[pos + 1][s - 1], arr[pos + 1][s] || 0].max
      end
    end

    pos -= 1
  end

  arr[0][12]
end

AOC.part2(read_lines: true) do |input|
  input.reduce(0) do |sum, line|
    sum + dp(line.chars.map(&:to_i))
  end
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 17229
  raise unless part2_sol == 170520923035051
end
