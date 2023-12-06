# frozen_string_literal: true

seeds = []

# https://stackoverflow.com/questions/190740/setting-ruby-hash-default-to-a-list
mappings = {} # { "source" => ["destination", source_range_start, source_range_len, offset] }

current_source = ""
current_dest = ""

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

    this_mappings = mappings[current_source] || Array.new
    this_mappings.push([current_dest, source, range_size, (dest - source)])
    mappings[current_source] = this_mappings
  end
end


locations = []
seeds.each do |seed|
  type = "seed"
  val = seed
  while type != "location"
    print "#{val} => "
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
  puts val
  locations.push val
end

puts locations.min
