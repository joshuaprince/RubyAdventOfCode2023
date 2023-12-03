# frozen_string_literal: true

class Trial
  attr_reader :red, :green, :blue
  def initialize(r, g, b)
    @red = r
    @green = g
    @blue = b
  end
end

total = 0

IO.foreach("./day2/day2.txt") do |line|
  m = /Game (\d+): (.*)/.match(line)
  id = Integer(m[1])
  trials_text = m[2]
  trials = trials_text.split("; ").map { |trial|
    r = /(\d+) red/.match(trial) { |m| Integer(m[1]) } || 0
    g = /(\d+) green/.match(trial) { |m| Integer(m[1]) } || 0
    b = /(\d+) blue/.match(trial) { |m| Integer(m[1]) } || 0
    Trial.new(r, g, b)
  }

  rmax = trials.max_by { |t| t.red }.red
  gmax = trials.max_by { |t| t.green }.green
  bmax = trials.max_by { |t| t.blue }.blue
  total += (rmax * gmax * bmax)
end

puts total
