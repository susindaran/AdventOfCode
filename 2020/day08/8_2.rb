# frozen_string_literal: true

require_relative '../../aoc'

class Instruction
  attr_reader :operation, :operand, :executed
  attr_accessor :visited

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
    when 'nop', 'acc'
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
end

def fix_program(instructions, line, flipped)
  instruction = instructions[line]
  return false if instruction.visited

  next_line = instruction.next_line
  instruction.visited = true

  # The program is fixed if the current instruction is the last line of the
  # program and it leads to termination, or if the upcoming instructions lead to
  # successful program termination.
  return true if next_line == instructions.length || fix_program(instructions, next_line, flipped)

  # Flip the instruction if it is flippable and if no instruction has been
  # flipped so far.
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
  instructions = program.map.with_index { |line, index| Instruction.new(line, index) }

  fix_program(instructions, 0, false)

  ins_index = 0
  accumulator = 0
  accumulator, ins_index = instructions[ins_index].execute(accumulator) until ins_index >= instructions.length
  accumulator
end

AOC.problem do |input|
  input.map!(&:chomp)
  find_acc_value(input)
end
