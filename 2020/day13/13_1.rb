# frozen_string_literal: true

require_relative '../../aoc'

def find_earliest(start_time, ids)
  time = start_time
  loop do
    eligible_id = ids.find { |id| (time % id).zero? }
    return (time - start_time) * eligible_id unless eligible_id.nil?

    time += 1
  end
end

AOC.problem do |input|
  input.map!(&:chomp)
  start_time = input[0].to_i
  ids = input[1].split(',').filter { |id| id != 'x' }.map(&:to_i)
  find_earliest(start_time, ids)
end
