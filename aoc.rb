# frozen_string_literal: true

module AOC
  # Reads all the lines of the input and yields to the block
  def self.problem(input_file: 'input', read_lines: true)
    if read_lines
      file = File.open(input_file)
      input = file.readlines
    else
      input = File.read(input_file)
    end
    puts yield(input)
  end
end
