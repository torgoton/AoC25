#!/usr/bin/env ruby
# Gift Shop

input_file = ARGV[0]

if input_file.nil?
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit 1
end

puts "Looking for invalid IDs in: #{input_file}"

@invalid_count = 0
@invalid_sum = 0

File.open(input_file, 'r') do |f|
  input = f.readline
  range_strings = input.split(',').map(&:strip)
  @ranges = range_strings.map do |range_str|
    bounds = range_str.split('-').map(&:to_i)
    (bounds[0]..bounds[1])
  end
end
puts "Ranges: #{@ranges.inspect}"

@ranges.each do |r|
  r.each do |id|
    s = id.to_s
    l = s.length
    if l.even?
      mid = l / 2
      if s[0...mid] == s[mid..-1]
        @invalid_count += 1
        @invalid_sum += id
        puts "Invalid ID found: #{id}"
      end
    end
  end
end

puts "Invalid count: #{@invalid_count}"
puts "Invalid sum: #{@invalid_sum}"
puts "End of script"

