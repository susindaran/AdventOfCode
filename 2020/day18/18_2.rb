# frozen_string_literal: true

require_relative '../../aoc'

def to_postfix(exp)
  stack = []
  postfix = ''

  exp.chars.each do |char|
    case char
    when '('
      stack.push char
    when ')'
      postfix += stack.pop until stack.last == '('
      stack.pop
    when '*', '+'
      postfix += stack.pop until stack.empty? || stack.last == '(' || (stack.last == '*' && char == '+')
      stack.push char
    else
      stack.push char
    end
  end

  postfix += stack.pop until stack.empty? || stack.last == '('

  postfix
end

def solve_exp(exp)
  stack = []

  exp.chars.each do |char|
    case char
    when /\d+/
      stack.push char.to_i
    else
      stack.push stack.pop.method(char.to_sym).call(stack.pop)
    end
  end

  stack.pop
end

AOC.problem do |input|
  input.map! { |line| line.chomp.gsub(' ', '') }
  input.map { |line| solve_exp(to_postfix(line)) }.sum
end
