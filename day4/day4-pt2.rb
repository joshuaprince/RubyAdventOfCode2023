# frozen_string_literal: true

require 'set'

N_CARDS = 198

card_counts = [1] * (N_CARDS + 1)
card_counts[0] = 0

IO.foreach("./day4/day4.txt") do |line|
  m = /Card\s+(\d+): ([\d\s]+) \| ([\d\s]+)/.match(line)
  unless m
    next
  end
  card_num = Integer(m[1])
  winning_str = m[2]
  mine_str = m[3]

  # Count winning numbers
  n_winning_numbers = 0
  winning = Set.new(winning_str.split(" "))
  mine_str.split(" ").each { |m|
    if winning.include? m
      n_winning_numbers += 1
    end
  }

  # Give bonus cards
  (0..n_winning_numbers-1).each do |idx|
    card_counts[card_num + idx + 1] += card_counts[card_num]
  end
end

puts card_counts.sum
