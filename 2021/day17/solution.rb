# frozen_string_literal: true

require_relative '../../aoc'

def parse_input(input)
  regex = /: x=(\d+)..(\d+), y=([-0-9]+)..([-0-9]+)/
  match = regex.match(input)
  [match[1].to_i, match[2].to_i, match[3].to_i, match[4].to_i]
end

AOC.part1(read_lines: false) do |input|
  _, _, y_start, y_end = parse_input(input)

  lowest = [y_start, y_end].min.abs
  (lowest * (lowest - 1)) / 2
end

AOC.part2(read_lines: false) do |input|
  x_start, x_end, y_start, y_end = parse_input(input)

  res = 0
  (y_start..y_start.abs).each do |y_vel_seed|
    (0..x_end).each do |x_vel_seed|
      x_vel = x_vel_seed
      y_vel = y_vel_seed

      x, y = 0, 0
      loop do
        x, y = x + x_vel, y + y_vel
        x_vel -= 1 if x_vel.positive?
        y_vel -= 1

        break if x > x_end || y < y_start
        next if x < x_start || y > y_end

        res += 1
        break
      end
    end
  end

  res
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 5886
  raise unless part2_sol == 1806
end
