# frozen_string_literal: true

require_relative '../../aoc'
require 'set'

Food = Struct.new(:ingredients, :allergens)

def solve(foods)
  allergen_map = {}
  all_ing = Set.new

  foods.each do |food|
    all_ing.merge(food.ingredients)
    food.allergens.each do |allergen|
      allergen_map[allergen] = if allergen_map.key?(allergen)
                                 allergen_map[allergen].intersection(food.ingredients)
                               else
                                 Set.new(food.ingredients)
                               end
    end
  end

  inert_ingredients = all_ing.to_a - allergen_map.values.reduce(&:+).to_a
  foods.map { |food| (food.ingredients & inert_ingredients).length }.sum
end

AOC.problem do |input|
  input.map! do |food|
    # mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    captures = food.chomp.match(/^([a-z ]+) \(contains ([a-z ,]+)\)$/)
    Food.new(captures[1].split(' '), captures[2].split(', '))
  end

  solve(input)
end
