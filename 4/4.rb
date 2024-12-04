#!/usr/bin/ruby

# MMMSXXMASM
# MSAMXMSMSA
# AMXSXMAAMM
# MSAMASMSMX
# XMASAMXAMM
# XXAMMXXAMA
# SMSMSASXSS
# SAXAMASAAA
# MAMMMXMMMM
# MXMXAXMASX

#         0123456789
#      0  ....XXMAS.
#      1  .SAMXMS...
#      2  ...S..A...
#      3  ..A.A.MS.X
#      4  XMASAMX.MM
#      5  X.....XA.A
#      6  S.S.S.S.SS
#      7  .A.A.A.A.A
#      8  ..M.M.M.MM
#      9  .X.X.XMASX

def process_input(filename, rows)
  File.open(filename, "r") do |file|
    file.each_line do |line|
      rows << line.chars
    end
  end
end

class Grid
  def initialize(rows)
    @rows = rows
    @max_rows = rows.length-1
    @max_cols = rows[0].length-1
    @sequence = ['X', 'M', 'A', 'S']
    @matches = []
  end

  def check_for_xmas(row_index, col_index)
    # check_horizontal_forward(row_index, col_index)
    check_generic(row_index, col_index, 'static', 'positive', 'horizontal forward')
    check_generic(row_index, col_index, 'static', 'negative', 'horizontal backward')
    check_generic(row_index, col_index, 'positive', 'static', 'vertical down')
    check_generic(row_index, col_index, 'negative', 'static', 'vertical up')
    check_generic(row_index, col_index, 'negative', 'positive', 'diag UR')
    check_generic(row_index, col_index, 'positive', 'positive', 'diag DR')
    check_generic(row_index, col_index, 'negative', 'negative', 'diag UL')
    check_generic(row_index, col_index, 'positive', 'negative', 'diag DL')

  end

  def find_matches
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        if col == 'X'
          check_for_xmas(row_index, col_index)
        end
      end
    end
  end

  def matches
    @matches
  end

  private

  def add_match(row, col, direction)
    @matches << { row: row, col: col, direction: direction }
  end

  def check_generic(row_index, col_index, row_direction, col_direction, match_label='generic')
    row_check_1, row_check_2, row_check_3 = 0, 0, 0
    col_check_1, col_check_2, col_check_3 = 0, 0, 0

    if row_direction == 'positive'
      row_check_1 = row_index + 1
      row_check_2 = row_index + 2
      row_check_3 = row_index + 3
    elsif row_direction == 'negative'
      row_check_1 = row_index - 1
      row_check_2 = row_index - 2
      row_check_3 = row_index - 3
    elsif row_direction == 'static'
      row_check_1 = row_index
      row_check_2 = row_index
      row_check_3 = row_index
    end

    if col_direction == 'positive'
      col_check_1 = col_index + 1
      col_check_2 = col_index + 2
      col_check_3 = col_index + 3
    elsif col_direction == 'negative'
      col_check_1 = col_index - 1
      col_check_2 = col_index - 2
      col_check_3 = col_index - 3
    elsif col_direction == 'static'
      col_check_1 = col_index
      col_check_2 = col_index
      col_check_3 = col_index
    end

    if row_check_3 > @max_rows ||
       row_check_3 < 0 ||
       col_check_3 > @max_cols ||
      col_check_3 < 0
      return
    end

    if @rows[row_check_1][col_check_1] == 'M' &&
       @rows[row_check_2][col_check_2] == 'A' &&
       @rows[row_check_3][col_check_3] == 'S'
      add_match(row_index, col_index, match_label)
    end
  rescue => e
    puts "row_index: #{row_index}, col_index: #{col_index}"
    puts "max_rows: #{@max_rows}, max_cols: #{@max_cols}"
    puts "row_direction: #{row_direction}, col_direction: #{col_direction}"
    puts "row_check_1: #{row_check_1}, col_check_1: #{col_check_1}"
    puts "row_check_2: #{row_check_2}, col_check_2: #{col_check_2}"
    puts "row_check_3: #{row_check_3}, col_check_3: #{col_check_3}"
    raise "oops"
  end
end

rows = []
process_input('4-input.txt', rows)
grid = Grid.new(rows)

grid.find_matches

puts "total XMAS's found: #{grid.matches.length}"