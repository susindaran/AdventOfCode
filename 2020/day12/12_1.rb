# frozen_string_literal: true

require_relative '../../aoc'

class Instruction
  attr_reader :action, :unit

  def initialize(instruction)
    @action = instruction[0]
    @unit = instruction[1...instruction.length].to_i
  end
end

class Ship
  def initialize
    @x = 0
    @y = 0
    @direction = 0
  end

  def turn(direction, degree)
    offset = (direction == 'L' ? -1 : 1) * (degree / 90)
    @direction = (@direction + 4 + offset) % 4
  end

  def move(instruction)
    directions = [[1, 0], [0, -1], [-1, 0], [0, 1]]
    case instruction.action
    when 'N'
      @y += instruction.unit
    when 'S'
      @y -= instruction.unit
    when 'E'
      @x += instruction.unit
    when 'W'
      @x -= instruction.unit
    when 'L', 'R'
      turn(instruction.action, instruction.unit)
    when 'F'
      @x += (instruction.unit * directions[@direction][0])
      @y += (instruction.unit * directions[@direction][1])
    end
  end

  def distance
    @x.abs + @y.abs
  end
end

def find_distance(input)
  location = Ship.new
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
