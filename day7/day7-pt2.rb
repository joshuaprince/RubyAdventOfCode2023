# frozen_string_literal: true

in_file = './day7/day7.txt'

class Hand
  attr_reader :str, :ranking, :bid, :score

  def initialize(str, ranking, bid, score)
    @str = str
    @ranking = ranking
    @bid = bid
    @score = score
  end
end

FIVE_KIND = 7
FOUR_KIND = 6
FULL_HOUSE = 5
THREE_KIND = 4
TWO_PAIR = 3
ONE_PAIR = 2
HIGH = 1

hands = IO.foreach(in_file).map do |line|
  m = /(\w{5}) (\d+)/.match(line)
  str = m[1]
  bid = Integer(m[2])

  jokers = str.count('J')
  counts = str.split('').map { |card|
    if card == 'J'
      0
    else
      str.count(card) + jokers
    end
  }.sort.reverse

  if counts[0] == 5 || counts[0] == 0
    ranking = FIVE_KIND
  elsif counts[0] == 4
    ranking = FOUR_KIND
  elsif (counts == [3,3,3,2,2]) || (counts == [3,3,3,3,0])
    ranking = FULL_HOUSE
  elsif counts[0] == 3
    ranking = THREE_KIND
  elsif (counts[0] == 2) && (counts[2] == 2) && (counts[4] != 0)
    ranking = TWO_PAIR
  elsif counts[0] == 2
    ranking = ONE_PAIR
  elsif counts[0] == 1
    ranking = HIGH
  else
    throw "missing hand #{str}"
  end

  # effective score
  score = ranking
  str.split('').each do |card|
    value = case card
    when 'A'
      14
    when 'K'
      13
    when 'Q'
      12
    when 'J'
      1 # weakest for ties
    when 'T'
      10
    else
      Integer(card)
    end
    score = score * 15 + value
  end

  Hand.new(str, ranking, bid, score)
end

sorted_hands = hands.sort_by(&:score)

puts(sorted_hands.each_with_index.sum { |h, idx| h.bid * (idx + 1) })

puts sorted_hands.map { |h| "#{h.str} (#{h.ranking})" }
