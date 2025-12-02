#!/usr/bin/env ruby
# Gift Shop

input_file = ARGV[0]
any_length = !!ARGV[1]

if input_file.nil?
  puts "Usage: ruby #{__FILE__} <input_file> [any_length]"
  exit 1
end

puts "Looking for invalid IDs in: #{input_file}"

@invalid_count = 0
@invalid_sum = 0

def check_valid(id, any_length: false)
  l = id.length
  mid = l / 2
  if !any_length
    if l.even?
      if id[0...mid] == id[mid..-1]
        @invalid_count += 1
        @invalid_sum += id.to_i
        puts "Invalid ID found: #{id}"
      end
    end
    return
  end
  (1..(mid)).each do |sample|
    target = id[0...sample]
    if id == target * (l / sample)
      @invalid_count += 1
      @invalid_sum += id.to_i
      puts "Invalid ID found: #{id} (repeats #{target})"
      return
    end
  end
end

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
    check_valid(s, any_length: any_length)
  end
end

puts "Invalid count: #{@invalid_count}"
puts "Invalid sum: #{@invalid_sum}"
puts "End of script"

