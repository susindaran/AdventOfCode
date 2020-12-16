# frozen_string_literal: true

require_relative '../../aoc'

require 'set'

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

def find_error_rate(rules, my_ticket, nearby_tickets)
  field_names = rules.map(&:field_name)
  tickets = nearby_tickets.select { |ticket| ticket.valid?(rules) }

  # Maintains a list of possible field names for each position
  field_order = Array.new(field_names.length) { Set.new(field_names) }

  tickets.each do |ticket|
    ticket.values.each_with_index do |value, index|
      matching_fields = rules.filter { |rule| rule.satisfies(value) }.map(&:field_name)
      field_order[index] = field_order[index].intersection(matching_fields)
    end
  end

  confirmed, unconfirmed = field_order.partition { |order| order.length == 1 }
  until unconfirmed.empty?
    unconfirmed.each do |order|
      next if order.length == 1

      confirmed.each do |c|
        order.subtract(c)
      end
    end

    confirmed, unconfirmed = unconfirmed.partition { |order| order.length == 1 }
  end

  field_order = field_order.map(&:to_a).flatten
  my_ticket.values.each_with_index.map do |value, index|
    field_order[index].start_with?('departure') ? value : 1
  end.reduce(&:*)
end

AOC.problem do |input|
  sections = input.join('').split("\n\n").map { |section| section.split("\n") }

  rules = sections[0].map { |rule_str| Rule.new(rule_str) }
  my_ticket = Ticket.new(sections[1][1])
  nearby_tickets = sections[2][1..].map { |ticket_str| Ticket.new(ticket_str) }

  find_error_rate(rules, my_ticket, nearby_tickets)
end
