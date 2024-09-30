# frozen_string_literal: true

require_relative '../../aoc'

AOC.problem(read_lines: false) do |input|
  regex = /: x=(\d+)..(\d+), y=([-0-9]+)..([-0-9]+)/
  match = regex.match(input)
  x_start, x_end, y_start, y_end = match[1].to_i, match[2].to_i, match[3].to_i, match[4].to_i

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

DEBUG = false

def failed_attempt_to_avoid_brute_force(input)
  regex = /: x=(\d+)..(\d+), y=([-0-9]+)..([-0-9]+)/
  match = regex.match(input)
  x_start, x_end, y_start, y_end = match[1].to_i, match[2].to_i, match[3].to_i, match[4].to_i

  sums = (0..y_start.abs).map { |x| (x * (x + 1)) / 2 }
  # Map of number of steps to y_axis of zone and # of ways to do it
  y_steps_to_zone = {}

  (1..y_start.abs).each do |left|
    (left..y_start.abs).each do |right|
      sum = sums[right] - sums[left - 1]
      next if sum < y_end.abs
      break if sum > y_start.abs

      direct_steps = right - left + 1
      indirect_steps = (((left - 1) * 2) + 1) + direct_steps

      puts "For #{left} => #{direct_steps}, #{indirect_steps}" if DEBUG

      y_steps_to_zone[direct_steps] = (y_steps_to_zone[direct_steps] || []) + [-left]
      y_steps_to_zone[indirect_steps] = (y_steps_to_zone[indirect_steps] || []) + [left - 1]
    end
  end

  puts "y_steps_to_zone = #{y_steps_to_zone.sort}\n" if DEBUG

  sums = (0..x_end.abs / 2).map { |x| (x * (x + 1)) / 2 }

  result = 0
  (1..x_end.abs / 2).each do |right|
    local_sum = Set.new
    (1..right).each do |left|
      sum = sums[right] - sums[left - 1]
      puts "checking #{left} #{right} with #{sum}" if DEBUG

      break if sum < x_start.abs
      next if sum > x_end.abs

      steps = right - left + 1

      if left == 1
        y_steps_to_zone.each do |k, v|
          local_sum.merge v if k >= steps
        end
      elsif y_steps_to_zone.key? steps
        local_sum.merge y_steps_to_zone[steps]
      end

      puts "#{left}, #{right} reaches #{sum} in #{steps} steps" if DEBUG
    end
    puts "local sum for #{right} => #{local_sum}" if DEBUG
    result += local_sum.size
  end

  result + ((x_end - x_start + 1) * (y_start.abs - y_end.abs + 1))
end
