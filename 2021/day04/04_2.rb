# frozen_string_literal: true

require_relative '../../aoc'

class Cell
  attr_reader :val, :row, :col, :marked
  def initialize(val, row, col)
    @val = val
    @row = row
    @col = col
    @marked = false
  end

  def mark
    @marked = true
  end
end

class Board
  def initialize(grid)
    @grid = grid
  end

  def win?
    @grid.any? { |row| row.all?(&:marked) } ||
      @grid.transpose.any? { |col| col.all?(&:marked) }
  end

  def score
    @grid.map { |row| row.map { |cell| cell.marked ? 0 : cell.val }.sum }.sum
  end

  def self.build(lines, number_map)
    grid = lines.split("\n").map.each_with_index do |line, row|
      line.split(' ').map.each_with_index do |val, col|
        val = val.strip.to_i
        cell = Cell.new(val, row, col)
        number_map[val] << cell
        cell
      end
    end

    Board.new(grid)
  end
end

AOC.problem(read_lines: false) do |lines|
  parts = lines.split("\n\n")
  numbers = parts[0].split(',').map(&:to_i)

  number_map = Hash.new { |h, k| h[k] = [] }
  boards = parts[1..].map { |part| Board.build(part, number_map) }

  losing_score = nil
  numbers.each do |num|
    number_map[num].each(&:mark)
    boards.dup.each do |board|
      next unless board.win?

      if boards.length > 1
        boards.delete(board)
      else
        losing_score = board.score * num
        break
      end
    end

    break unless losing_score.nil?
  end

  losing_score
end
