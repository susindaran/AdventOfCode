# frozen_string_literal: true

require_relative '../../aoc'

class CPU
  def initialize(&process_blk)
    @cycle = 1
    @reg = 1
    @process_blk = process_blk
  end

  def add(val)
    tick(2)
    @reg += val
  end

  def noop
    tick(1)
  end

  private

  def tick(cycles)
    cycles.times do
      @process_blk.call(@cycle, @reg)
      @cycle += 1
    end
  end
end

AOC.problem(read_lines: false) do |input|
  instructions = input.split("\n").map { |line| line.split(' ') }

  total = 0
  checkpoints = [20, 60, 100, 140, 180, 220]
  cpu = CPU.new { |cycle, reg| total += (cycle * reg) if checkpoints.include?(cycle) }

  instructions.each do |inst|
    case inst[0]
    when 'addx'
      cpu.add inst[1].to_i
    when 'noop'
      cpu.noop
    end
  end

  total
end
