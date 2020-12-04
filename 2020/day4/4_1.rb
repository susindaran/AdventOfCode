# frozen_string_literal: true

require_relative '../../template'

def valid_passports(input)
  input = input.join('')
  passports = input.gsub("\n", '##').gsub('####', "\n").gsub('##', ' ').split("\n")

  required_fields = %w[byr iyr eyr hgt hcl ecl pid].sort
  passports.filter do |passport|
    actual_fields = passport.split(' ').map { |field_value| field_value.split(':')[0] }.sort
    (required_fields - actual_fields).length.zero?
  end.length
end

input_file_name = File.basename(__FILE__).split('.')[0]
AOC.problem input_file_name do |input|
  valid_passports(input)
end
