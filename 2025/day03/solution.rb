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

AOC.part2(read_lines: true) do |input|
  input.reduce(0) do |sum, line|
    bats = line.chars.map(&:to_i)

    dp = Array.new(13)
    dp[1] = bats[-1]

    pos = bats.size - 2
    while pos >= 0
      12.downto(1).each do |len|
        if len == 1
          dp[len] = [bats[pos], dp[len]].max
        elsif !dp[len - 1].nil?
          # See if we get a higher number using bats[pos] + highest number of length (len-1) seen so far
          dp[len] = [(bats[pos] * (10 ** (len - 1)) + dp[len - 1]), dp[len] || 0].max
        end
      end

      pos -= 1
    end

    sum + dp[12]
  end
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 17229
  raise unless part2_sol == 170520923035051
end
