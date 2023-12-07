# frozen_string_literal: true

# Parsing logic is for long inputs :)
times = [46, 82, 84, 79]
distances_to_beat = [347, 1522, 1406, 1471]

# times = [7,15,30]
# distances_to_beat = [9,40,200]

accum = 1
times.zip(distances_to_beat).each do |time, distance_to_beat|
  ways_to_beat = 0
  (0..time).each do |hold_time|
    speed = hold_time
    run_time = time - hold_time
    distance = run_time * speed

    if distance > distance_to_beat
      ways_to_beat += 1
    end
  end
  accum *= ways_to_beat
end

puts accum
