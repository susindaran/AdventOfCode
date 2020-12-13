# frozen_string_literal: true

require_relative '../../aoc'

def find_earliest(ids)
  time = ids.first[0]
  step = 1

  ids.each do |id, offset|
    time += step until ((time + offset) % id).zero?
    step *= id
  end

  time
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input = input.map(&:chomp)[1].split(',')

  ids = input.each_with_index.filter_map do |id, idx|
    next if id == 'x'

    [id.to_i, idx]
  end

  find_earliest(ids)
end
