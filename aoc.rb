# frozen_string_literal: true

require 'benchmark'

module AOC
  # Reads all the lines of the input and yields to the block
  def self.problem(input_file: 'input', read_lines: true)
    if read_lines
      file = File.open(input_file)
      input = file.readlines(chomp: true)
    else
      input = File.read(input_file)
    end
    puts yield(input)
  end

  def self.part1(input_file: 'input', read_lines: true, &blk)
    @part1 = lambda do
      if read_lines
        file = File.open(input_file)
        input = file.readlines(chomp: true)
      else
        input = File.read(input_file)
      end
      blk.call(input)
    end
  end

  def self.part2(input_file: 'input', read_lines: true, &blk)
    @part2 = lambda do
      if read_lines
        file = File.open(input_file)
        input = file.readlines(chomp: true)
      else
        input = File.read(input_file)
      end
      blk.call(input)
    end
  end

  def self.solve
    part1_sol, part2_sol = nil, nil

    time = Benchmark.measure do
      part1_sol = @part1&.call
    end
    puts "Part 1: #{part1_sol} [time taken: #{time.to_s.strip}]"

    time = Benchmark.measure do
      part2_sol = @part2&.call
    end
    puts "Part 2: #{part2_sol} [time taken: #{time.to_s.strip}]"

    [part1_sol, part2_sol]
  end

  def self.validate_solution
    yield(*solve)
  end
end
