# frozen_string_literal: true

require_relative '../../aoc'
require 'set'

class Tile
  attr_reader :id, :neighbours, :grid

  def initialize(id, grid, neighbours = Set.new)
    @id = id
    @grid = grid
    @neighbours = neighbours
  end

  def height; @grid.length end
  def width; @grid[0].length end

  def top; @grid[0] end
  def right; @grid.map(&:last) end
  def bottom; @grid.last end
  def left; @grid.map(&:first) end

  def borders; [top, right, bottom, left] end

  def rotate; Tile.new(@id, @grid.transpose.map(&:reverse), @neighbours) end
  def flip; Tile.new(@id, @grid.map(&:reverse), @neighbours) end

  def all_orientations
    (0..3).flat_map do |x|
      rotated_tile = x.times.inject(self) { |tile, _| tile.rotate }
      [rotated_tile, rotated_tile.flip]
    end
  end

  def remove_borders
    @grid = grid[1...-1].map { |row| row[1...-1] }
  end

  def add(neighbour)
    @neighbours.add(neighbour)
  end

  def to_s
    y = @grid.map { |x| x.join('') }.join("\n")
    "Tile: #{@id}\n#{y}"
  end
end

def find_neighbours(tiles)
  m = {}
  tiles.each do |tile|
    tile.borders.each do |border|
      m[border] = [] unless m.key?(border)
      m[border] << tile

      reversed = border.reverse
      m[reversed] = [] unless m.key?(reversed)
      m[reversed] << tile
    end
  end

  m.each_value do |sharing|
    next if sharing.length <= 1

    sharing.each do |tile|
      (sharing - [tile]).each do |other|
        tile.add(other)
      end
    end
  end

  m
end

def arrange_tiles(tiles, neighbours_map)
  image_grid_size = Integer.sqrt(tiles.length)
  image_grid = Array.new(image_grid_size) { Array.new(image_grid_size) }

  # Find any corner tile - this will be at (0, 0) in our final image grid
  corner = tiles.find { |tile| tile.neighbours.length == 2 }

  # Find the orientation of the corner tile in which the borders of the tile that
  # don't match with another tile are facing top and left
  corner = corner.all_orientations.find do |orientation|
    outside_edges = orientation.borders.select { |border| neighbours_map[border].length == 1 }
    outside_edges.include?(orientation.left) && outside_edges.include?(orientation.top)
  end

  image_grid[0][0] = corner

  image_grid.each_with_index do |image_grid_row, image_grid_row_idx|
    # Set the first tile of the row
    if image_grid_row_idx.positive?
      # Take the first tile of the previous row and select a neighbour of that tile
      # in the proper orientation such that the neighbour's top border matches
      # the bottom border of the above tile
      tile_above = image_grid[image_grid_row_idx - 1][0]
      tile_above.neighbours.each do |neighbour|
        found_ori = neighbour.all_orientations.find do |orientation|
          orientation.top == tile_above.bottom
        end
        next if found_ori.nil?

        image_grid_row[0] = found_ori
        break
      end
    end

    # Starting from the left most tile of the row, find the tile to the right of
    # it by looking for a match for the left tile's right edge.
    (1...image_grid_row.length).each do |image_grid_col_idx|
      tile_left = image_grid_row[image_grid_col_idx - 1]
      tile_left.neighbours.each do |neighbour|
        found_ori = neighbour.all_orientations.find do |orientation|
          orientation.left == tile_left.right
        end
        next if found_ori.nil?

        image_grid_row[image_grid_col_idx] = found_ori
        break
      end
    end
  end

  image_grid
end

def stitch_image(image_grid)
  image_grid.flat_map do |row|
    row.each(&:remove_borders)
    (0...row[0].height).map do |tile_row|
      row.flat_map { |tile| tile.grid[tile_row] }
    end
  end
end

def find_monster(image, monster)
  all_matched_points = Set.new
  monster.all_orientations.each do |monster_ori|
    (0..image.length - monster_ori.grid.length).each do |row|
      (0..image.length - monster_ori.grid[0].length).each do |col|
        matched_points = Set.new
        mismatch = false
        monster_ori.grid.each_with_index do |m_row, m_row_idx|
          m_row.each_with_index do |m_cell, m_col_idx|
            next if m_cell == '.'

            if m_cell == image[row + m_row_idx][col + m_col_idx]
              matched_points << [row + m_row_idx, col + m_col_idx]
            else
              mismatch = true
            end
          end
        end
        all_matched_points += matched_points unless mismatch
      end
    end
  end

  image.flatten.count { |cell| cell == '#' } - all_matched_points.length
end

def monster
  pattern = ['..................#.', '#....##....##....###', '.#..#..#..#..#..#...'].map(&:chars)
  Tile.new('monster', pattern)
end

AOC.problem do |input|
  tiles = input.join('').split("\n\n")
  tiles = tiles.map do |tile|
    lines = tile.split("\n")
    id = lines[0].split(' ')[1].gsub(':', '')
    Tile.new(id, lines[1..].map(&:chars))
  end

  m = find_neighbours(tiles)
  image_grid = arrange_tiles(tiles, m)
  image = stitch_image(image_grid)
  find_monster(image, monster)
end
