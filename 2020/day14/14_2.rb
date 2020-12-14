# frozen_string_literal: true

require_relative '../../aoc'

class Mask
  def initialize(value)
    @or = 0
    @float_locations = []
    value.reverse.chars.each_with_index do |bit, index|
      next if bit == '0'

      if bit == 'X'
        @float_locations << index
      else
        @or |= (1 << index)
      end
    end
  end

  def apply(value)
    values = [value | @or]

    # For each float bit location, generate a new list of values by transforming
    # each previously generated value to two new values by setting and unsetting
    # the bit at the float bit location.
    @float_locations.each do |location|
      values.map! { |a| [a & ~(1 << location), a | (1 << location)] }.flatten!
    end

    values
  end
end

def find_sum(program)
  memory = {}
  mask = nil

  program.each do |instruction, value|
    case instruction
    when 'mask'
      mask = Mask.new(value)
    else
      raise 'No mask configured' if mask.nil?

      address = instruction.match(/^mem\[([0-9]+)\]$/)[1].to_i
      value = value.to_i

      mask.apply(address).each do |addr|
        memory[addr] = value
      end
    end
  end

  memory.values.sum
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map! { |line| line.chomp.split(' = ') }
  find_sum(input)
end
