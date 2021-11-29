# frozen_string_literal: true

require_relative '../../aoc'

def resolve_rule(id, rules)
  return "(?<left>#{resolve_rule('42', rules)}\\g<left>*#{resolve_rule('31', rules)})" if id == '11'
  return "(#{resolve_rule('42', rules)})+" if id == '8'

  value = rules[id]
  return value if value.match(/^[a-z]+$/)

  parts = value.split('|').map(&:strip)

  resolved = parts.map do |part|
    ids = part.split(' ')
    ids.map do |char|
      resolve_rule(char, rules)
    end.join('')
  end.join('|')

  resolved = '(' + resolved + ')' if parts.length > 1
  resolved
end

def find_matching(rules, messages)
  rules = rules.map { |rule| rule.split(':') }.to_h
  resolved = '^' + resolve_rule('0', rules) + '$'

  messages.map { |msg| msg.match(resolved) ? 1 : 0 }.sum
end

AOC.problem do |input|
  rules, messages = input.join('').split("\n\n")
  rules = rules.gsub('"', '').gsub(': ', ':').split("\n")
  messages = messages.split("\n")
  find_matching(rules, messages)
end
