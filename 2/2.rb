#!/usr/bin/ruby

# 7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1
# 1 3 6 7 9

MIN_DELTA = 1
MAX_DELTA = 3

def process_input(filename, reports)
  File.open(filename, "r") do |file|
    file.each_line do |line|
      reports << line.split.map{|n|n.to_i}
    end
  end
end

def safe_report?(report, debug=false)
  puts "-----------------------------------"  if debug
  safe = true
  puts "R: #{report}" if debug
  growing = (report[1] - report[0]) > 0
  puts "  growing? #{growing}" if debug

  report.each_with_index do |val, i|
    next_val = report[i+1]
    next unless next_val
    delta = next_val - val

    puts "    #{i}: comparing #{val} to #{next_val}, delta: #{delta}" if debug
    if growing && delta < 1 || !growing && delta > -1
      puts "      not safe. grow/shrink" if debug
      safe = false
      break
    end
    if delta.abs < MIN_DELTA || delta.abs > MAX_DELTA
      puts "      not safe. delta out of range" if debug
      safe = false
      break
    end

    break unless safe
  end

  safe
end

reports = []
puts "reports to start #{reports}"
process_input('2-input.txt', reports)
puts "reports after parse #{reports.length}\n\n"

safe_count = 0
reports.each do |report|
  result = safe_report?(report)

  # problem dampener
  if result == false
    # puts "Unsafe Report: #{report}"
    (0..report.length-1).each do |target_index|
      # puts target_index
      partial_report = report.reject.with_index { |_, index| index == target_index }
      # puts "  Check partial report: #{partial_report}"
      partial_report_safe = safe_report?(partial_report)
      if partial_report_safe
        result = true
        break
      end
    end
  end

  safe_count += 1 if result == true
end
puts "Safe reports: #{safe_count}"
