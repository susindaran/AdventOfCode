def trees_encountered(input)
  trees = 0
  map = input.map(&:chars)
  cols = map[0].length
  row = 0
  col = 0
  while row < map.length
    trees += 1 if map[row][col] == '#'
    row += 1
    col = (col + 3) % cols
  end
  trees
end

# read input
filename = File.basename(__FILE__).split('.')[0]
file = File.open("#{filename}.input")
input = file.readlines.map(&:chomp)
puts trees_encountered(input)
