# frozen_string_literal: true

require 'fileutils'

def create_problem_template(day, day_dir, problem_number)
  program_file = "#{day_dir}/#{day}_#{problem_number}.rb"
  input_file = "#{day_dir}/#{day}_#{problem_number}.input"
  FileUtils.cp('template.rb', program_file) unless File.exist?(program_file)
  FileUtils.touch(input_file) unless File.exist?(input_file)
end

year = ARGV[0]
day = ARGV[1]
puts "Creating template for Year: #{year}, day: #{day}"

# Create year directory if not exists
Dir.mkdir(year) unless File.exist?(year)

# Create day directory if not exists
day_dir = "#{year}/day#{day}"
Dir.mkdir(day_dir) unless File.exist?(day_dir)

# Create problem files (program and input file)
create_problem_template(day, day_dir, 1)
create_problem_template(day, day_dir, 2)
