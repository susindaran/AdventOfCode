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

  dangerous_ings = allergen_map.values.filter { |ing| ing.length == 1 }.map(&:to_a).flatten

  until dangerous_ings.length == allergen_map.length
    allergen_map.values.each do |food_ings|
      next if food_ings.length == 1

      food_ings.subtract(dangerous_ings)
    end

    dangerous_ings = allergen_map.values.filter { |ing| ing.length == 1 }.map(&:to_a).flatten
  end

  allergen_map.keys.sort.map { |allergen| allergen_map[allergen].to_a[0] }.join(',')
end

AOC.problem do |input|
  input.map! do |food|
    # mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    captures = food.chomp.match(/^([a-z ]+) \(contains ([a-z ,]+)\)$/)
    Food.new(captures[1].split(' '), captures[2].split(', '))
  end

  solve(input)
end
