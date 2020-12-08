# frozen_string_literal: true

require_relative '../../aoc'

class Instruction
  attr_reader :operation, :operand, :executed

  def initialize(line, line_number)
    parts = line.split(' ')
    @line_number = line_number
    @operation = parts[0]
    @operand = parts[1].to_i
    @executed = false
  end

  def execute(accumulator)
    @executed = true
    new_acc = case @operation
              when 'nop'
                accumulator
              when 'acc'
                accumulator + @operand
              when 'jmp'
                accumulator
              else
                accumulator
              end
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
  index = -1
  instructions = program.map do |line|
    index += 1
    Instruction.new(line, index)
  end

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
