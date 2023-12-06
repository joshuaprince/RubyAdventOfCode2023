# frozen_string_literal: true

# Programmer's note: It's a miracle this worked.

seeds = []

mappings = {} # { "source" => ["destination", source_range_start, source_range_len, offset] }

current_source = ""
current_dest = ""

smallest_range = 2 ** 63

IO.foreach("./day5/day5.txt").with_index do |line, line_num|
  if (m = /^seeds: ([\d\s]+)$/.match(line))
    seeds += m[1].split(" ").map { |v| Integer(v) }
  end

  if (m = /^(\w+)-to-(\w+) map:$/.match(line))
    current_source = m[1]
    current_dest = m[2]
  end

  if (m = /^(\d+) (\d+) (\d+)$/.match(line))
    dest = Integer(m[1])
    source = Integer(m[2])
    range_size = Integer(m[3])
    if range_size < smallest_range
      smallest_range = range_size
    end

    this_mappings = mappings[current_source] || Array.new
    this_mappings.push([current_dest, source, range_size, (dest - source)])
    mappings[current_source] = this_mappings
  end
end

puts smallest_range

def run(seed, mappings)
  type = "seed"
  val = seed
  while type != "location"
    # print "#{val} => "
    mappings[type].each do |mapping|
      dest_type = mapping[0]
      source_range_start = mapping[1]
      source_range_len = mapping[2]
      offset = mapping[3]

      type = dest_type # load destination for next iteration
      if val >= source_range_start and val < (source_range_start + source_range_len)
        val += offset
        break
      end
    end
  end
  val
end

lowest_candidate_seed = 0
lowest_candidate_location = 2 ** 63 # No Integer.MAX definition in Ruby?
i = 0
while i < seeds.size
  puts "Start seed #{seeds[i]} search."
  (seeds[i]..(seeds[i] + seeds[i + 1])).step(smallest_range).each { |seed|
    location = run(seed, mappings)
    # puts val
    if location <= lowest_candidate_location
      lowest_candidate_seed = seed
      lowest_candidate_location = location
      puts location
    end
  }
  i += 2
end

puts lowest_candidate_seed
puts lowest_candidate_location

while true
  down = run(lowest_candidate_seed - 1, mappings)
  puts "#{lowest_candidate_seed - 1} => #{down}"
  if down > lowest_candidate_location
    break
  end
  lowest_candidate_location = down
  lowest_candidate_seed -= 1
end

puts lowest_candidate_location
