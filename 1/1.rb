#!/usr/bin/ruby

def process_input(filename, list)
  File.open(filename, "r") do |file|
    file.each_line do |line|
      # puts "parse line: #{line}"
      line.split.each_with_index do |number, i|
        list[i] ||= []
        list[i].push(number.to_i)
      end
    end
  end
  list.each do |sublist|
    sublist.sort!
  end
end

list = []
puts "list to start #{list}"
list = process_input('1-input.txt', list)

puts "list after parse #{list[0].length}"

delta = 0

list[0].each_index do |i|
  location_1 = list[0][i]
  location_2 = list[1][i]
  location_diff = (location_1 - location_2).abs
  delta += location_diff
  # puts "diff between #{location_1} and #{location_2} is #{location_diff}. New delta is #{delta}"
end

puts "final delta is #{delta}"