# frozen_string_literal: true

require 'fileutils'

def create_problem_template(day_dir)
  program_file = "#{day_dir}/solution.rb"
  FileUtils.cp('template.rb', program_file) unless File.exist?(program_file)

  input_file = "#{day_dir}/input"
  FileUtils.touch(input_file) unless File.exist?(input_file)
end

year = ARGV[0]
day = ARGV[1]
puts "Creating template for Year: #{year}, day: #{day}"

# Create year directory if not exists
FileUtils.mkdir_p(year)

# Create day directory if not exists
day_dir = "#{year}/day#{day}"
FileUtils.mkdir_p(day_dir)

# Create problem files (solution and input file)
create_problem_template(day_dir)
