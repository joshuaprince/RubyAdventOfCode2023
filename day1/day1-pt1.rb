# frozen_string_literal: true

count = 0

IO.foreach("./day1.txt").each { |line|
  i = 0
  while i < line.length
    if line[i][/^-?\d+$/]
      count += 10 * Integer(line[i])
      break
    end
    i += 1
  end

  i = -1
  while i >= -line.length
    if line[i][/^-?\d+$/]
      count += Integer(line[i])
      break
    end
    i -= 1
  end
}

puts count
