# frozen_string_literal: true

require_relative '../../aoc'

AOC.part1(read_lines: true) do |input|
  pos = 50
  count = 0
  input.each do |line|
    dir, mag = line[0], line[1..].to_i

    if dir == 'L'
      pos -= mag
    else
      pos += mag
    end

    pos = 100 - (pos.abs % 100) if pos.negative?
    pos = pos % 100

    count += 1 if pos.zero?
  end

  count
end

AOC.part2(read_lines: true) do |input|
  pos = 50
  count = 0
  input.each do |line|
    dir, mag = line[0], line[1..].to_i

    # Count obvious 0 crossings
    if mag >= 100
      count += mag / 100
      mag = mag % 100
    end

    if dir == 'L'
      pos -= mag
    else
      pos += mag
    end

    if pos.negative?
      count += 1 unless pos.abs == mag # don't count if we started at 0
      pos = 100 - (pos.abs % 100)
    end

    count += pos / 100 unless pos % 100 == 0 # avoid double counting if stopped at 0
    pos = pos % 100
    count += 1 if pos.zero?
  end

  count
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 969
  raise unless part2_sol == 5_887
end
