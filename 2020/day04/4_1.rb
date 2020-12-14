# frozen_string_literal: true

require_relative '../../aoc'

def valid_passports(input)
  input = input.join('')
  passports = input.gsub("\n", '##').gsub('####', "\n").gsub('##', ' ').split("\n")

  required_fields = %w[byr iyr eyr hgt hcl ecl pid].sort
  passports.filter do |passport|
    actual_fields = passport.split(' ').map { |field_value| field_value.split(':')[0] }.sort
    (required_fields - actual_fields).length.zero?
  end.length
end

AOC.problem do |input|
  valid_passports(input)
end
