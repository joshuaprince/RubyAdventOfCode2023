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

coords_to_number_ids = {}
number_ids_to_numbers = {}

last_number_id = 0
# This time, store all the numbers at their locations
IO.foreach(in_file).with_index do |line, line_num|
  current_number = 0
  number_starts_at = nil
  line.each_char.with_index do |ch, pos|
    if /(\d)/.match(ch)
      current_number *= 10
      current_number += Integer(ch)
      unless number_starts_at
        number_starts_at = pos
      end
    else
      if current_number > 0
        (number_starts_at..pos-1).each { |n|
          coord = Coordinate.new(line_num, n)
          coords_to_number_ids[coord] = last_number_id
          number_ids_to_numbers[last_number_id] = current_number
        }
        last_number_id += 1
      end
      current_number = 0
      number_starts_at = nil
    end
  end
end

# Then scan for all gears
total = 0
IO.foreach(in_file).with_index do |line, line_num|
  line.each_char.with_index do |ch, pos|
    if /\*/.match(ch)
      number_ids_nearby = Set.new
      [line_num - 1, line_num, line_num + 1].each { |l|
        [pos - 1, pos, pos + 1].each { |p|
          number_there = coords_to_number_ids[Coordinate.new(l, p)]
          if number_there != nil
            number_ids_nearby.add number_there
          end
        }
      }
      if number_ids_nearby.size == 2
        a = number_ids_nearby.to_a
        total += number_ids_to_numbers[a[0]] * number_ids_to_numbers[a[1]]
      end
    end
  end
end

puts number_ids_to_numbers
puts coords_to_number_ids
puts total
