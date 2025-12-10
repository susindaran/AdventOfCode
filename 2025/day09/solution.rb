# frozen_string_literal: true

require_relative '../../aoc'

AOC.part1(read_lines: true) do |input|
  points = input.map { |line| line.split(',').map(&:to_i) }

  pairs = points.combination(2).to_a

  pairs.map do |pair|
    ((pair[0][0] - pair[1][0]).abs + 1) *
      ((pair[0][1] - pair[1][1]).abs + 1)
  end.max
end

def inside?(row_borders, col_borders, row, col)
  row_borders[col][0] <= row && row <= row_borders[col][1] &&
    col_borders[row][0] <= col && col <= col_borders[row][1]
end

def all_inside?(row_borders, col_borders, rows, cols)
  (rows.min..rows.max).all? { |row| inside?(row_borders, col_borders, row, cols.min) && inside?(row_borders, col_borders, row, cols.max) } &&
    (cols.min..cols.max).all? { |col| inside?(row_borders, col_borders, rows.min, col) && inside?(row_borders, col_borders, rows.max, col) }
end

AOC.part2(read_lines: true) do |input|
  points = input.map { |line| line.split(',').map(&:to_i) }
  cons_pairs = points.each_cons(2).to_a + [[points[-1], points[0]]]

  col_borders = Hash.new { |h, k| h[k] = Set.new }
  row_borders = Hash.new { |h, k| h[k] = Set.new }

  cons_pairs.each do |pair|
    rows = [pair[0][1], pair[1][1]]
    cols = [pair[0][0], pair[1][0]]

    if rows[0] == rows[1]
      col_borders[rows[0]].merge(cols)
      (cols.min..cols.max).each { |col| row_borders[col].add(rows[0]) }
    else
      (rows.min..rows.max).each { |row| col_borders[row].add(cols[0])}
      row_borders[cols[0]].merge(rows)
    end
  end

  col_borders.transform_values! { |v| [v.min, v.max] }
  row_borders.transform_values! { |v| [v.min, v.max] }


  pairs = points.combination(2).to_a

  # Order the pairs by their area in decreasing order and check if one of them is inside the boundaries
  # This way we can terminate early as soon as we find the first pair that is inside.
  areas = pairs.map do |pair|
    area = ((pair[0][0] - pair[1][0]).abs + 1) * ((pair[0][1] - pair[1][1]).abs + 1)
    [pair, area]
  end.sort_by { |x| -x[1] }

  _, max_area = areas.find do |pair, area|
    rows = [pair[0][1], pair[1][1]]
    cols = [pair[0][0], pair[1][0]]

    all_inside?(row_borders, col_borders, rows, cols)
  end
  max_area
end

AOC.validate_solution do |part1_sol, part2_sol|
  raise unless part1_sol == 4771508457
  raise unless part2_sol == 1539809693
end
