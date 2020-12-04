def trees_encountered(input)
  slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  map = input.map(&:chars)
  cols = map[0].length

  total_trees = 1

  slopes.each do |slope|
    trees = 0

    row = 0
    col = 0
    while row < map.length
      trees += 1 if map[row][col] == '#'
      row += slope[1]
      col = (col + slope[0]) % cols
    end
    total_trees *= trees
  end

  total_trees
end

# read input
filename = File.basename(__FILE__).split('.')[0]
file = File.open("#{filename}.input")
input = file.readlines.map(&:chomp)
puts trees_encountered(input)
