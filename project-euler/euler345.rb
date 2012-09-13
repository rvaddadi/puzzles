#this one was difficult, as I thought it would be
#had to look for help on the internet and found this nice
#implementation of Hungarian Algorithm by Evan Senter
# before that, I tried several different approaches, including
# the first genetic algorithm I ever implemented \o/


GRID_TEST = [[7, 53, 183, 439, 863],
  [497, 383, 563, 79, 973],
  [287, 63, 343, 169, 583],
  [627, 343, 773, 959, 943],
  [767, 473, 103, 699, 303]]

GRID = [[7, 53, 183, 439, 863, 497, 383, 563, 79, 973, 287, 63, 343, 169, 583],
  [627, 343,773, 959, 943, 767, 473, 103, 699, 303, 957, 703, 583, 639, 913],
  [447, 283, 463, 29, 23, 487, 463, 993, 119, 883, 327, 493, 423, 159, 743],
  [217, 623, 3, 399, 853, 407, 103, 983, 89, 463, 290, 516, 212, 462, 350],
  [960, 376, 682, 962, 300, 780, 486, 502, 912, 800, 250, 346, 172, 812, 350],
  [870, 456, 192, 162, 593, 473, 915, 45, 989, 873, 823, 965, 425, 329, 803],
  [973, 965, 905, 919, 133, 673, 665, 235, 509, 613, 673, 815, 165, 992, 326],
  [322, 148, 972, 962, 286, 255, 941, 541, 265, 323, 925, 281, 601, 95, 973],
  [445, 721, 11, 525, 473, 65, 511, 164, 138, 672, 18, 428, 154, 448, 848],
  [414, 456, 310, 312, 798, 104, 566, 520, 302, 248, 694, 976, 430, 392, 198],
  [184, 829, 373, 181, 631, 101, 969, 613, 840, 740, 778, 458, 284, 760, 390],
  [821, 461, 843, 513, 17, 901, 711, 993, 293, 157, 274, 94, 192, 156, 574],
  [34, 124, 4, 878, 450, 476, 712, 914, 838, 669, 875, 299, 823, 329, 699],
  [815, 559, 813, 459, 522, 788, 168, 586, 966, 232, 308, 833, 251, 631, 107],
  [813, 883, 451, 509, 615, 77, 281, 613, 459, 205, 380, 274, 302, 35, 805]]
# Written by: Evan Senter
#
# - - - - - U S A G E - - - - -
#
# hungarian = Hungarian.new(matrix_to_solve)
# solution  = hungarian.solve
#
# ...or...
#
# hungarian = Hungarian.new
# solution  = hungarian.solve(matrix_to_solve)
# 
# The method solve returns an array of cell locations such that the assignment problem is solved.
# See http://en.wikipedia.org/wiki/Hungarian_algorithm for more information on this problem.
#
# Adapted from: http://www.public.iastate.edu/~ddoty/HungarianAlgorithm.html

class Hungarian
  EMPTY = 0
  STAR  = 1
  PRIME = 2
  
  def initialize(matrix = nil); setup(matrix) if matrix; end
    
  def solve(matrix = nil)
    setup(matrix) if matrix
    raise "You must provide a matrix to solve." unless @matrix
    
    method = :minimize_rows
    while method != :finished
      method = self.send(*method)
    end
    
    return assignment
  end
  
  private
  
  # - - - - - M A I N   S U B M E T H O D S - - - - -
  
  def minimize_rows
    # For each row of the matrix, find the smallest element and subtract it from every element in its row.
    
    @matrix.map! do |row|
      min_value = row.min
      row.map { |element| element - min_value }
    end
    
    return :star_zeroes
  end
  
  def star_zeroes
    # Find a zero (Z) in the resulting matrix. If there is no starred zero in its row or column, star Z. Repeat for each element in the matrix.
    
    traverse_indices do |row, column|
      if @matrix[row][column].zero? && !location_covered?(row, column)
        @mask[row][column] = STAR
        cover_cell(row, column)
      end
    end
    reset_covered_hash
    
    return :mask_columns
  end
  
  def mask_columns
    # Cover each column containing a starred zero. If all columns are covered, the starred zeros describe a complete set of unique assignments.
    
    index_range.each do |index|
      @covered[:columns][index] = true if column_mask_values_for(index).any? { |value| value == STAR }
    end
    
    return @covered[:columns].all? ? :finished : :prime_zeroes
  end
  
  def prime_zeroes
    # Find a noncovered zero and prime it. If there is no starred zero in the row containing this primed zero, call augment_path.
    # Otherwise, cover this row and uncover the column containing the starred zero. Continue in this manner until there are no uncovered zeros left
    # and call adjust_matrix.
    
    while (row, column = find_uncovered_zero) != [-1, -1]
      @mask[row][column] = PRIME
      
      if star_loc_in_row = row_mask_values_for(row).index(STAR)
        @covered[:rows][row] = true
        @covered[:columns][star_loc_in_row] = false
      else
        return :augment_path, row, column
      end
    end
    
    return :adjust_matrix
  end
  
  def augment_path(starting_row, starting_column) 
    # Construct a series of alternating primed and starred zeroes. Let Z0 represent the uncovered primed zero passed in.
    # Let Z1 denote the starred zero in the column of Z0 (if any). Let Z2 denote the primed zero in the row of Z1 (there will always be one).
    # Continue until the series terminates at a primed zero that has no starred zero in its column. Unstar each starred zero of the series, 
    # star each primed zero of the series, erase all primes and uncover every line in the matrix, and call mask_columns.
    
    path = [[starting_row, starting_column]]
    path.instance_eval do
      def previous_row;    self.last[0]; end
      def previous_column; self.last[1]; end
    end
    
    loop do
      if row_containing_star = column_mask_values_for(path.previous_column).index(STAR)
        path << [row_containing_star, path.previous_column]
      else
        break
      end
      
      col_containing_prime = row_mask_values_for(path.previous_row).index(PRIME)
      path << [path.previous_row, col_containing_prime]
    end
    
    update_elements_in(path)
    traverse_indices { |row, column| @mask[row][column] = EMPTY if @mask[row][column] == PRIME }
    reset_covered_hash
    
    return :mask_columns
  end
  
  def adjust_matrix
    # Add the smallest value to every element of each covered row, subtract it from every element of each uncovered column, and call prime_zeroes.
    
    smallest_value = nil
    traverse_indices do |row, column| 
      if !location_covered?(row, column) && (smallest_value.nil? || @matrix[row][column] < smallest_value)
        smallest_value = @matrix[row][column]
      end
    end
    
    indices_of_covered_rows.each { |index| @matrix[index].map! { |value| value + smallest_value } }

    covered_columns = indices_of_uncovered_columns
    index_range.each { |row| covered_columns.each { |column| @matrix[row][column] -= smallest_value } }
    
    return :prime_zeroes
  end
  
  # - - - - - H E L P E R   M E T H O D S - - - - -
  
  def setup(matrix)
    @matrix  = matrix
    @length  = @matrix.length
    @mask    = Array.new(@length) { Array.new(@length, EMPTY) }                               # 2D array of constants (listed above)
    @covered = { :rows => Array.new(@length, false), :columns => Array.new(@length, false) }  # Boolean arrays
  end
  
  def assignment
    index_range.inject([]) { |path, row_index| path << [row_index, @mask[row_index].index(STAR)] }
  end
  
  def update_elements_in(path)    
    path.each do |cell|
      @mask[cell[0]][cell[1]] = case @mask[cell[0]][cell[1]]
      when STAR  then EMPTY
      when PRIME then STAR
      end
    end
  end
  
  def find_uncovered_zero
    traverse_indices do |row, column|
      return [row, column] if @matrix[row][column].zero? && !location_covered?(row, column)
    end
    [-1, -1]
  end
  
  def cover_cell(row, column)
    @covered[:rows][row] = @covered[:columns][column] = true
  end
  
  def reset_covered_hash
    @covered.values.each { |cover| cover.fill(false) }
  end
  
  def location_covered?(row, column)
    @covered[:rows][row] || @covered[:columns][column]
  end
  
  def row_mask_values_for(row)
    index_range.map { |column| @mask[row][column] }
  end
  
  def column_mask_values_for(column)
    index_range.map { |row| @mask[row][column] }
  end
  
  def indices_of_covered_rows
    index_range.select { |index| @covered[:rows][index] }
  end
    
  def indices_of_uncovered_columns
    index_range.select { |index| !@covered[:columns][index] }
  end
  
  def traverse_indices(&block)
    index_range.each { |row| index_range.each { |column| yield row, column } }
  end
  
  def index_range; (0...@length); end
end
class Array
  def invert_min_max!
    max = self.map { |row| row.max}.max
    self.each_index { |row_index| self[row_index].each_index { |column_index| self[row_index][column_index] = max - self[row_index][column_index] } }
  end
end
matrix = Marshal.load( Marshal.dump(GRID))
inverted_matrix = Marshal.load( Marshal.dump(GRID)).invert_min_max!

p Hungarian.new.solve(inverted_matrix).map { |coordinates| matrix[coordinates[0]][coordinates[1]] }.reduce(:+)
