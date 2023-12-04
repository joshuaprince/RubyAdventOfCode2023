# frozen_string_literal: true

require 'set'

class Coordinate
  attr_reader :line, :pos
  def initialize(line, pos)
    @line = line
    @pos = pos
  end

  def to_s
    "(#{@line},#{@pos})"
  end

  def eql?(other)
    @line == other.line and @pos == other.pos
  end

  def hash
    @line * 100000 + @pos
  end
end

in_file = "./day3/day3.txt"
symbol_re = /[^\d.\n]/

symbol_locations = Set.new

# Build all symbol locations to avoid backtracking
IO.foreach(in_file).with_index do |line, line_num|
  line.each_char.with_index do |ch, pos|
    if symbol_re.match(ch)
      symbol_locations.add Coordinate.new(line_num, pos)
    end
  end
end

puts symbol_locations

def scan_for_symbol?(symbols, coord)
  [coord.line - 1, coord.line, coord.line + 1].each { |l|
    [coord.pos - 1, coord.pos, coord.pos + 1].each { |p|
      if symbols.include? Coordinate.new(l, p)
        return true
      end
    }
  }
  false
end


# Find each number and see if there is a symbol nearby
total = 0
IO.foreach(in_file).with_index do |line, line_num|
  current_number = 0
  symbol_around = false
  line.each_char.with_index do |ch, pos|
    if /(\d)/.match(ch)
      unless symbol_around
        symbol_around = scan_for_symbol?(symbol_locations, Coordinate.new(line_num, pos))
      end

      current_number *= 10
      current_number += Integer(ch)
    else
      if current_number > 0 and symbol_around
        total += current_number
      end
      current_number = 0
      symbol_around = false
    end
  end
end

puts total
