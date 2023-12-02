# frozen_string_literal: true

number_names = {
  "zero" => "0",
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9",
}

count = 0

IO.foreach("./day1/day1.txt").each { |line|
  closest_idx = number_names.min_by { |num_name, num|
    [line.index(num_name) || line.length, line.index(num) || line.length].min
  }
  count += 10 * Integer(closest_idx[1])

  furthest_idx = number_names.max_by { |num_name, num|
    [line.rindex(num_name) || -1, line.rindex(num) || -1].max
  }
  count += Integer(furthest_idx[1])
}

puts count
