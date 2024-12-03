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

cumulative_similarty_score = 0

list[0].each_index do |i|
  location_1 = list[0][i]

  # get the copunt
  number_of_occurrences = list[1].count(location_1)

  similarity_score = location_1 * number_of_occurrences

  cumulative_similarty_score += similarity_score
  puts "list 1, value #{location_1} appears #{number_of_occurrences} times in list 2. similarity score is #{similarity_score}. running score is now #{cumulative_similarty_score}"

end

puts "final similarity score is #{cumulative_similarty_score}"