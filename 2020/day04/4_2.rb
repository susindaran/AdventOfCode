# frozen_string_literal: true

require_relative '../../aoc'

def valid_passport?(passport)
  unless passport['byr'].match?(/^[0-9]{4}$/) && passport['byr'].to_i >= 1920 && passport['byr'].to_i <= 2002
    # puts passport['byr']
    return false
  end

  unless passport['iyr'].match?(/^[0-9]{4}$/) && passport['iyr'].to_i >= 2010 && passport['iyr'].to_i <= 2020
    # puts passport['iyr']
    return false
  end

  unless passport['eyr'].match?(/^[0-9]{4}$/) && passport['eyr'].to_i >= 2020 && passport['eyr'].to_i <= 2030
    # puts passport['eyr']
    return false
  end

  # Validate hgt
  match_data = passport['hgt'].match(/^([0-9]{2,3})(cm|in)$/)
  return false unless match_data

  height = match_data[1].to_i
  case match_data[2]
  when 'cm'
    unless height >= 150 && height <= 193
      # puts passport['hgt']
      return false
    end
  when 'in'
    unless height >= 59 && height <= 76
      # puts passport['hgt']
      return false
    end
  end

  unless passport['hcl'].match(/^\#[0-9a-f]{6}$/)
    # puts passport['hcl']
    return false
  end

  unless passport['ecl'].match(/^(amb|blu|brn|gry|grn|hzl|oth)$/)
    # puts passport['ecl']
    return false
  end

  unless passport['pid'].match(/^[0-9]{9}$/)
    # puts passport['pid']
    return false
  end

  true
end

def valid_passports(input)
  input = input.join('')

  # Replace newlines with '##', which leads to empty lines replaced with '####'
  # Replace empty lines ('####') with a single newline
  # Replace remaining '##' with space
  # This will give us one passport per line. So, finally split by newline
  passports = input.gsub("\n", '##').gsub('####', "\n").gsub('##', ' ').split("\n")

  required_fields = %w[byr iyr eyr hgt hcl ecl pid].sort
  passports.filter do |passport|
    field_map = passport.split(' ').map { |field| field.split(':') }.to_h
    (required_fields - field_map.keys.sort).length.zero? && valid_passport?(field_map)
  end.length
end

AOC.problem do |input|
  valid_passports(input)
end
