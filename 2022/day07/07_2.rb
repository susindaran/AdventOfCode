# frozen_string_literal: true

require_relative '../../aoc'

# Can't name this `File` as it clashes with core library's File class
class FileObject
  attr_reader :name, :size
  def initialize(name, size)
    @name = name
    @size = size
  end
end

class Dir
  attr_reader :path, :files, :dirs

  def initialize(path)
    @path = path
    @contents = []
    @size = nil
  end

  def add(content)
    @contents << content
  end

  def size
    @size ||= (@contents.map(&:size).reduce(&:+) || 0)
  end
end

class Tree
  attr_reader :dirs
  def initialize(inputs)
    @inputs = inputs
    @read_idx = -1

    # Setup root dir
    root_dir = Dir.new('/')
    @dirs = { root_dir.path => root_dir }
    @dir_stack = []
  end

  def next_line?
    @read_idx + 1 < @inputs.size
  end

  def next_line
    @read_idx += 1
    @inputs[@read_idx]
  end

  def curr_dir
    @dir_stack.last
  end

  def new_path(path)
    curr_dir.nil? ? path : "#{curr_dir.path}#{path}/"
  end

  def dir(dir_name)
    new_dir = Dir.new(new_path(dir_name))
    curr_dir.add(new_dir)
    @dirs[new_dir.path] = new_dir
  end

  def cd(path)
    if path == '..'
      @dir_stack.pop
      return
    end

    # Sine all 'cd' commands are preceeded by 'dir' output from a previous 'ls' command
    # we should be guaranteed to have the dir available in `@dirs`
    new_dir = @dirs[new_path(path)]
    @dir_stack.push(new_dir)
  end

  def add_file(name, size)
    curr_dir.add(FileObject.new(name, size))
  end

  def parse
    while next_line?
      line = next_line
      parts = line.split(' ')
      case parts[0]
      when '$'
        case parts[1]
        when 'cd'
          cd(parts[2])
        when 'ls'
          # do nothing
        end
      when 'dir'
        dir(parts[1])
      else
        add_file(parts[1], parts[0].to_i)
      end
    end
  end
end

AOC.problem do |input|
  tree = Tree.new(input)
  tree.parse

  used_space = tree.dirs['/'].size
  free_space = 70_000_000 - used_space
  need_space = 30_000_000 - free_space

  tree.dirs.values.filter_map { |dir| dir.size if dir.size >= need_space }.min
end
