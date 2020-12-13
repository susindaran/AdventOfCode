# frozen_string_literal: true

require_relative '../../aoc'

class Instruction
  attr_reader :action, :unit

  def initialize(instruction)
    @action = instruction[0]
    @unit = instruction[1...instruction.length].to_i
  end
end

class Location
  # N, E, W, S
  DIRECTION_MULTIPLIERS = {
    'N' => [0, 1],
    'E' => [1, 0],
    'W' => [-1, 0],
    'S' => [0, -1]
  }.freeze

  def initialize
    @waypoint_x = 10
    @waypoint_y = 1
    @ship_x = 0
    @ship_y = 0
  end

  def move(instruction)
    case instruction.action
    when 'N', 'E', 'W', 'S'
      @waypoint_x += DIRECTION_MULTIPLIERS[instruction.action][0] * instruction.unit
      @waypoint_y += DIRECTION_MULTIPLIERS[instruction.action][1] * instruction.unit
    when 'L'
      (instruction.unit / 90).times { @waypoint_x, @waypoint_y = (@waypoint_y * -1), @waypoint_x }
    when 'R'
      (instruction.unit / 90).times { @waypoint_x, @waypoint_y = @waypoint_y, (@waypoint_x * -1) }
    when 'F'
      @ship_x += (@waypoint_x * instruction.unit)
      @ship_y += (@waypoint_y * instruction.unit)
    end
  end

  def distance
    @ship_x.abs + @ship_y.abs
  end
end

def find_distance(input)
  location = Location.new
  input
    .map { |line| Instruction.new(line) }
    .each { |instruction| location.move(instruction) }
  location.distance
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map!(&:chomp)
  find_distance(input)
end
