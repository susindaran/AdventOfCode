# frozen_string_literal: true

require_relative '../../aoc'

class Packet
  attr_reader :idx, :version_sum, :expr, :val
  def initialize(bin, idx)
    @bin = bin
    @idx = idx
    @version_sum = 0
    @expr = ''
    @val = 0
  end

  def parse
    ver = read_version
    type = read_type

    if type == 4
      literal =  read_literal
      @val = literal
      @expr += "#{literal}"
    else
      len_type = read_len_type

      if len_type == '0'
        total_len = read_num(15)
        condition = lambda { |bits_read, _| bits_read < total_len }
      elsif len_type == '1'
        num_packets = read_num(11)
        condition = lambda { |_, packets_read| packets_read < num_packets }
      else
        raise "Unexpected packet length type '#{len_type}'"
      end

      sub_packets = []
      bits_read, packets_read = 0, 0
      while condition.call(bits_read, packets_read)
        sub_packet = Packet.new(@bin, @idx)
        sub_packet.parse
        sub_packets << sub_packet

        bits_read += (sub_packet.idx - @idx)
        packets_read += 1
        @idx = sub_packet.idx
      end

      case type
      when 0
        @val = sub_packets.map(&:val).sum
        @expr += "(#{sub_packets.map(&:expr).join(' + ')})"
      when 1
        @val = sub_packets.map(&:val).reduce(&:*)
        @expr += "(#{sub_packets.map(&:expr).join(' * ')})"
      when 2
        @val = sub_packets.map(&:val).min
        @expr += "(min[#{sub_packets.map(&:expr).join(', ')}])"
      when 3
        @val = sub_packets.map(&:val).max
        @expr += "(max[#{sub_packets.map(&:expr).join(', ')}])"
      when 5
        raise "Too many operands for operation type '#{type}' (expected 2, but got #{sub_packets.size})" if sub_packets.size > 2
        @val = sub_packets[0].val > sub_packets[1].val ? 1 : 0
        @expr += "(#{sub_packets.map(&:expr).join(' > ')})"
      when 6
        raise "Too many operands for operation type '#{type}' (expected 2, but got #{sub_packets.size})" if sub_packets.size > 2
        @val = sub_packets[0].val < sub_packets[1].val ? 1 : 0
        @expr += "(#{sub_packets.map(&:expr).join(' < ')})"
      when 7
        raise "Too many operands for operation type '#{type}' (expected 2, but got #{sub_packets.size})" if sub_packets.size > 2
        @val = sub_packets[0].val == sub_packets[1].val ? 1 : 0
        @expr += "(#{sub_packets.map(&:expr).join(' == ')})"
      else
        raise "Unexpected operation type '#{type}'"
      end

      @version_sum += sub_packets.map(&:version_sum).sum
    end
  end

  private
  def read_version
    @version_sum += @bin[@idx...@idx+3].to_i(2)
    @idx += 3
    @version_sum
  end

  def read_type
    type = @bin[@idx...@idx+3].to_i(2)
    @idx += 3
    type
  end

  def read_len_type
    len_type = @bin[@idx]
    @idx += 1
    len_type
  end

  def read_literal
    read_next = true
    num = ''

    while read_next
      part = @bin[@idx...@idx+5]
      @idx += 5

      read_next = part[0] == '1'
      num += part[1..]
    end

    num.to_i(2)
  end

  def read_num(bits)
    num = @bin[@idx...@idx+bits].to_i(2)
    @idx += bits
    num
  end
end

AOC.problem(read_lines: false) do |input|
  bin = input.chars.map { |x| x.hex.to_s(2).rjust(4, '0') }.join('')

  p = Packet.new(bin, 0)
  p.parse
  puts p.expr
  p.val
end
