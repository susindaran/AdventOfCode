# frozen_string_literal: true

require_relative '../../aoc'

def invalid?(num)
  c = num.chars
  (1..num.size/2).any? do |chunk_size|
    if num.size % chunk_size > 0
      false
    else
      chunks = c.each_slice(chunk_size).to_a.map {|x| x.join }
      chunks[1..].all? { |chunk| chunk == chunks[0] }
    end
  end
end

AOC.part1(read_lines: false) do |input|
  ranges = input.strip.split(',').map { |range| range.split('-') }

  sum = 0
  ranges.each do |range|
    (range.first.to_i..range.last.to_i).each do |num|
      num_s = num.to_s
      if num_s.length % 2 == 0 && num_s[0...num_s.length / 2] == num_s[num_s.length / 2..]
        sum += num
      end
    end
  end

  sum
end

AOC.part2(read_lines: false) do |input|
  ranges = input.strip.split(',').map { |range| range.split('-') }

  sum = 0
  ranges.each do |range|
    (range.first.to_i..range.last.to_i).each do |num|
      sum += num if invalid?(num.to_s)
    end
  end

  sum
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 5_398_419_778
  raise unless part2_sol == 15_704_845_910
end
