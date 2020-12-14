# frozen_string_literal: true

require_relative '../../aoc'

class Mask
  def initialize(value)
    @or = 0
    @and = (2**36) - 1
    value.reverse.chars.each_with_index do |bit, index|
      next if bit == 'X'

      if bit.to_i.positive?
        @or |= (1 << index)
      else
        @and &= ~(1 << index)
      end
    end
  end

  def apply(value)
    (value | @or) & @and
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

      index = instruction.match(/^mem\[([0-9]+)\]$/)[1].to_i
      memory[index] = mask.apply(value.to_i)
    end
  end

  memory.values.sum
end

AOC.problem do |input|
  input.map! { |line| line.chomp.split(' = ') }
  find_sum(input)
end
