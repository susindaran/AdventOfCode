# frozen_string_literal: true

require_relative '../../aoc'

class Rule
  attr_reader :field_name

  def initialize(rule)
    @field_name, ranges = rule.split(': ')
    @ranges = ranges.split(' ').filter_map do |range|
      next if range == 'or'

      Range.new(range)
    end
  end

  def satisfies(value)
    @ranges.any? { |range| range.contains(value) }
  end
end
class Range
  def initialize(str)
    @first, @last = str.split('-').map(&:to_i)
  end

  def contains(value)
    @first <= value && value <= @last
  end
end

class Ticket
  attr_reader :values

  def initialize(str)
    @values = str.split(',').map(&:to_i)
  end

  def valid?(rules)
    @values.none? { |value| invalid_value?(value, rules) }
  end

  def get_invalid_values(rules)
    @values.filter { |value| invalid_value?(value, rules) }
  end

  private

  def invalid_value?(value, rules)
    rules.none? { |rule| rule.satisfies(value) }
  end
end

def find_error_rate(rules, _my_ticket, nearby_tickets)
  nearby_tickets.filter_map do |ticket|
    next if ticket.valid?(rules)

    ticket.get_invalid_values(rules).sum
  end.sum
end

AOC.problem do |input|
  sections = input.join('').split("\n\n").map { |section| section.split("\n") }

  rules = sections[0].map { |rule_str| Rule.new(rule_str) }
  my_ticket = Ticket.new(sections[1][1])
  nearby_tickets = sections[2][1..].map { |ticket_str| Ticket.new(ticket_str) }

  find_error_rate(rules, my_ticket, nearby_tickets)
end
