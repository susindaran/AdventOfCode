# frozen_string_literal: true

require 'fileutils'

def create_problem_template(day, day_dir)
  (1..2).each do |problem|
    program_file = "#{day_dir}/#{day}_#{problem}.rb"
    FileUtils.cp('template.rb', program_file) unless File.exist?(program_file)
  end

  input_file = "#{day_dir}/input"
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
create_problem_template(day, day_dir)
