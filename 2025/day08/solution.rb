# frozen_string_literal: true

require_relative '../../aoc'

def distance(p1, p2)
  Math.sqrt((p2[0] - p1[0])**2 + (p2[1] - p1[1])**2 + (p2[2] - p1[2])**2)
end

def connect_pair(sets, pair)
  circuits = sets.find_all { |set| set.include?(pair[0]) || set.include?(pair[1]) }
  if !circuits.empty?
    if circuits.size == 1
      circuits.first.merge(pair)
    else
      # Merge circuits if elements of the pair belong to two different circuits
      sets << sets.delete(circuits[0]) + sets.delete(circuits[1])
    end
  else
    sets << Set.new(pair)
  end
end

AOC.part1(read_lines: true) do |input|
  points = input.map { |line| line.split(',').map(&:to_i) }

  pairs = points.combination(2).to_a.sort_by { |pair| distance(pair[0], pair[1]) }
  sets = []

  pairs[0...1000].each { |pair| connect_pair(sets, pair) }

  sets.map(&:size).sort.last(3).reduce(&:*)
end

AOC.part2(read_lines: true) do |input|
  points = input.map { |line| line.split(',').map(&:to_i) }

  pairs = points.combination(2).to_a.sort_by { |pair| distance(pair[0], pair[1]) }
  sets = []

  pairs.find do |pair|
    connect_pair(sets, pair)
    sets.size == 1 && sets.first.size == points.size
  end.map(&:first).reduce(&:*)
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 102816
  raise unless part2_sol == 100011612
end
