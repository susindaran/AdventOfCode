# frozen_string_literal: true

require 'benchmark'
require 'pry'
require 'pry-byebug'

def env_set?(name)
  var = begin
          ENV[name].to_i || 0
        rescue
          0
        end
  var == 1
end

def benchmark?
  env_set?('BENCHMARK')
end

def debug?
  env_set?('DEBUG')
end

def breakpoint
  binding.pry if debug?
end

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

  def self.print_s(str, time)
    str += " [time taken: #{time.to_s.strip}]" if benchmark?
    puts str
  end


  def self.solve
    part1_sol, part2_sol = nil, nil

    time = Benchmark.measure do
      part1_sol = @part1&.call
    end
    print_s("Part 1: #{part1_sol}", time)

    time = Benchmark.measure do
      part2_sol = @part2&.call
    end
    print_s("Part 2: #{part2_sol}", time)

    [part1_sol, part2_sol]
  end

  def self.validate_solution
    yield(*solve)
  end
end
