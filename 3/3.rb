#!/usr/bin/ruby


def process_input(filename, lines)
  File.open(filename, "r") do |file|
    file.each_line do |line|
      lines << line
    end
  end
end

def process_mul(mul_string)
  matches = mul_string.match(/mul\((\d*)\,(\d*)\)/)
  matches[1].to_i * matches[2].to_i
end

def process_line(line)
  total = 0
  muls = line.scan(/mul\(\d*\,\d*\)/)
  muls.each do |m|
    total += process_mul(m)
  end
  total
end

lines = []
puts "lines to start #{lines}"
process_input('3-input.txt', lines)
puts "lines: #{lines.count}"

total = 0
lines.each do |line|
  total += process_line(line)
end

puts "total is #{total}"