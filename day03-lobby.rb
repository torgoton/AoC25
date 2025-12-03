#!/usr/bin/env ruby
# Lobby

input_file = ARGV[0]
# each_tick = !!ARGV[1]

if input_file.nil?
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit 1
end

puts "Searching for most joltage from file: #{input_file}"

@joltage_sum = 0
@bank_ord = 0

File.readlines(input_file, chomp: true).each do |bank|
  length = bank.length
  next if length == 0
  @bank_ord += 1
  bank_max = 0
  ratings = bank.chars.map(&:to_i)
  length.times do |i|
    ((i+1)...length).each do |j|
      candidate = 10 * ratings[i] + ratings[j]
      bank_max = candidate if candidate > bank_max
    end
  end
  puts "Max for bank #{@bank_ord}: #{bank_max}"
  @joltage_sum += bank_max
end

puts "MAX JOLTAGE: #{@joltage_sum}"

