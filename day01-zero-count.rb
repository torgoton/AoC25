#!/usr/bin/env ruby
# Zero Count
# This script reads an input file containing rotations of the safe's dial
# and counts how many times the dial points to zero.

# The input file should contain one rotation per line, with the rotation
# represented as a letter followed by a string of digits (e.g., "L12").
# The dial starts at 50, and each rotation moves the dial left or right
# The script outputs the count of rotations that point to zero.
# Usage: ruby zero_count.rb <input_file>
# Example: ruby zero_count.rb rotations.txt
input_file = ARGV[0]
each_tick = !!ARGV[1]

if input_file.nil?
  puts "Usage: ruby zero_count.rb <input_file> [each_tick]"
  puts "Any second argument enables each-tick mode"
  exit 1
end

puts "Counting zero positions from file: #{input_file}"
puts "Each tick mode: #{each_tick}"

@dial_position = 50
@zero_count = 0

def tally
  @zero_count += 1 if @dial_position == 0
end

File.readlines(input_file, chomp: true).each do |line|
  direction = line[0]
  ticks = line[1..-1].to_i

  if direction == 'L'
    if each_tick
      ticks.times do
        @dial_position = (@dial_position - 1) % 100
        tally
      end
    else
      @dial_position = (@dial_position - ticks) % 100
      tally
    end
  elsif direction == 'R'
    if each_tick
      ticks.times do
        @dial_position = (@dial_position + 1) % 100
        tally
      end
    else
      @dial_position = (@dial_position + ticks) % 100
      tally
    end
  else
    # ignore this line
  end

  puts "Line: #{line}, Dial Position: #{@dial_position}"
end

puts "zero_count: #{@zero_count}"

