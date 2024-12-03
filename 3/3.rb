#!/usr/bin/ruby

REGEX_MUL = /mul\(\d*\,\d*\)/
REGEX_DO = /do\(\)/
REGEX_DONT = /don\'t\(\)/
REGEX_ALL = Regexp.union(REGEX_MUL, REGEX_DO, REGEX_DONT)

def process_input(filename, lines)
  File.open(filename, "r") do |file|
    file.each_line do |line|
      lines << line
    end
  end
end

def process_mul(mul_string)
  matches = mul_string.match(/mul\((\d*)\,(\d*)\)/)
  result = matches[1].to_i * matches[2].to_i
  puts "process_mul: #{mul_string}, #{result}"
  result
end

def is_mul?(command)
  command.start_with?('mul')
end

def is_do?(command)
  command.start_with?('do(')
end

def is_dont?(command)
  command.start_with?('don')
end

def process_line(line)
  line_total = 0
  count = true
  commands = line.scan(REGEX_ALL)
  commands.each do |c|
    # puts "Command is #{c}"
    if is_dont?(c)
      # puts "stop counting"
      count = false
    elsif is_do?(c)
      # puts "start counting"
      count = true
    elsif is_mul?(c)
      if count
        line_total += process_mul(c)
      else
        # puts "skip mul"
      end
    end
    # puts "  line_total: #{line_total}"
  end
  line_total
end

lines = []
puts "lines to start #{lines}"
process_input('3-input.txt', lines)
puts "lines: #{lines.count}"

total = process_line(lines.join)
puts "total is #{total}"