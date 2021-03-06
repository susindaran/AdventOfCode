# frozen_string_literal: true

module AOC
  # Reads all the lines of the input and yields to the block
  def self.problem(input_file = 'input')
    file = File.open(input_file)
    input = file.readlines
    puts yield(input)
  end
end
