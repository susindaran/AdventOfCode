# frozen_string_literal: true

class PQ
  def initialize(&blk)
    if block_given?
      @comp = blk
    else
      @comp = lambda { |a, b| a <= b }
    end
    @arr = []
  end

  def push(ele)
    @arr << ele
    return if @arr.length == 1

    shift_up(@arr.length - 1)
  end

  def pop
    return @arr.pop if @arr.length <= 1

    ele = @arr.first
    @arr[0] = @arr.pop
    shift_down(0)

    return ele
  end

  def size
    @arr.size
  end

  def empty?
    @arr.empty?
  end

  def to_s
    @arr.to_s
  end

  private

  def parent(idx)
    (idx - 1) / 2
  end

  def left(idx)
    idx * 2 + 1
  end

  def right(idx)
    idx * 2 + 2
  end

  def swap(a, b)
    @arr[a], @arr[b] = @arr[b], @arr[a]
  end

  def shift_up(idx)
    parent = parent(idx)

    if parent > -1 && @comp.call(@arr[idx], @arr[parent])
      swap(idx, parent)
      shift_up(parent)
    end
  end

  def shift_down(idx)
    left, right = left(idx), right(idx)

    high_p = idx
    high_p = left if left < @arr.length && @comp.call(@arr[left], @arr[high_p])
    high_p = right if right < @arr.length && @comp.call(@arr[right], @arr[high_p])

    if high_p != idx
      swap(idx, high_p)
      shift_down(high_p)
    end
  end
end
