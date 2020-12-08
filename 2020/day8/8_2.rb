# frozen_string_literal: true

require_relative '../../aoc'

class Instruction
  attr_reader :operation, :operand, :executed
  attr_accessor :visited

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

  def flip_operation
    case @operation
    when 'nop'
      @operation = 'jmp'
    when 'jmp'
      @operation = 'nop'
    end
  end

  def to_s
    "#{@operation} #{@operand} #{@line_number}"
  end
end

def fix_program(instructions, line, flipped)
  instruction = instructions[line]
  return false if instruction.visited

  next_line = instruction.next_line
  instruction.visited = true

  # The program is fixed if the current instruction is the last line of the
  # program and it leads to termination, or if the upcoming instructions lead to
  # program termination.
  return true if next_line == instructions.length || fix_program(instructions, next_line, flipped)

  if %w[nop jmp].include?(instruction.operation) && !flipped
    instruction.flip_operation
    next_line = instruction.next_line
    return true if fix_program(instructions, next_line, true)

    instruction.flip_operation
  end

  instruction.visited = false
  false
end

def find_acc_value(program)
  index = -1
  instructions = program.map do |line|
    index += 1
    Instruction.new(line, index)
  end

  fix_program(instructions, 0, false)

  ins_index = 0
  accumulator = 0
  accumulator, ins_index = instructions[ins_index].execute(accumulator) until ins_index >= instructions.length
  accumulator
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  input.map!(&:chomp)
  find_acc_value(input)
end
