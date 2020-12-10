# frozen_string_literal: true

require_relative '../../aoc'

class Instruction
  attr_reader :operation, :operand, :executed

  def initialize(line, line_number)
    operation, operand = line.split(' ')
    @line_number = line_number
    @operation = operation
    @operand = operand.to_i
  end

  def execute(accumulator)
    @executed = true
    new_acc = @operation == 'acc' ? accumulator + @operand : accumulator
    [new_acc, next_line]
  end

  def next_line
    case @operation
    when 'nop'
      @line_number + 1
    when 'acc'
      @line_number + 1
    when 'jmp'
      @line_number + @operand
    else
      @line_number
    end
  end
end

def find_acc_value(program)
  instructions = program.map.with_index { |line, index| Instruction.new(line, index) }

  ins_index = 0
  accumulator = 0
  accumulator, ins_index = instructions[ins_index].execute(accumulator) until instructions[ins_index].executed
  accumulator
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map!(&:chomp)
  find_acc_value(input)
end
