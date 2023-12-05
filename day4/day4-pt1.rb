# frozen_string_literal: true

require 'set'

total = 0
IO.foreach("./day4/day4.txt") do |line|
  m = /Card\s+(\d+): ([\d\s]+) \| ([\d\s]+)/.match(line)
  unless m
    next
  end
  card_num = m[1]
  winning_str = m[2]
  mine_str = m[3]

  score = 0
  winning = Set.new(winning_str.split(" "))
  mine_str.split(" ").each { |m|
    if winning.include? m
      if score == 0
        score += 1
      else
        score *= 2
      end
    end
  }
  total += score
end

puts total
