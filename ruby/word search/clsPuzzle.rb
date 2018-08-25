############################################################
#
#  Name:        Kyle Stafford
#  Date:        06/07/2012
#  Class:       CIS 283
#  Assignment:  Word Search
#  Description: Puzzle Class for Word Search.
#               Program creates a word search from a text
#               file of words. Word search words are placed
#               randomly on the search grid.
#
############################################################

# PUZZLE CLASS
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class Puzzle
  attr_accessor( :words, :letters, :direction, :puzzle_grid, :answer_grid, :test_grid )       # Have ability to read and write to variables
  attr_reader( :file_name, :grid_size, :placeholder_char )                                    # Read only abilities
  def initialize( file_name, grid_size = 45, placeholder_char = "." )                         # Initialize method. Required - text file name, size of puzzle, character placeholder
    @file_name = file_name                                                                    # Variable for text file name
    @words = []                                                                               # Array of words to find in the word search
    @letters = []                                                                             # Array of letters to fill in the word search. Letters only come from the words being used
    @direction = []                                                                           # Array of the 8 directions to place the word on the puzzle
    @placeholder_char = placeholder_char.to_s                                                 # Character to use as the placeholder positions in the answer key
    @grid_size = grid_size.to_i                                                               # Variable containing the size of the puzzle
    add_words_from_file                                                                       # Method called to add words from the text file to the words array
    make_grid                                                                                 # Method called to create the word search grid from the grid size variable
  end


  # METHOD TO OBTAIN WORDS FROM A TEXT FILE AND ADD THEM TO AN ARRAY
  #------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def add_words_from_file
    file_words = File.open( @file_name )                                                                                  # Open text file
    file_words.each_line { | word | @words << ( word.include?( " " ) ? word.delete( " " ) : word ).chomp.upcase! }        # Get each word from separate line and adds them to the array
    file_words.close                                                                                                      # Close text file
    ( @words.sort_by! { | word | word.length } ).reverse!                                                                 # Sorts the words by length from longest to shortest
  end


  # METHOD TO ADD A SINGLE WORD TO THE LIST OF WORDS TO FIND IN THE PUZZLE
  #--------------------------------------------------------------------------------------------------------------------------------
  def add_single_word( word )
    @words << word.upcase!                                        # Makes all letters in the word uppercase
    ( @words.sort_by! { | words | words.length } ).reverse!       # Re-sorts the array of words by length, from longest to shortest
  end


  # METHOD TO MAKE THE PUZZLE GRID
  #--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def make_grid
    @answer_grid = Array.new( @grid_size ) { Array.new( @grid_size, @placeholder_char ) }       # Creates a new double array for the grid. Size and placeholder character is determined by user or default.
    @puzzle_grid = @answer_grid                                                                 # Copies newly created puzzle to be used as the answer key
    @test_grid = Array.new( @grid_size ) { Array.new( @grid_size ) }                            # Creates a test grid the same size as the puzzle grid. Used when placing words on the puzzle
  end


  # METHOD TO CREATE THE ANSWER KEY AND RETURN IT AS A STRING
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def make_answer_key
    position = ""                                                                                                                             # Creates new empty string variable
    @answer_grid.each { | row | row.each { | col | position += col == @placeholder_char ? @placeholder_char : col }; position += "\n" }       # If position on answer key is equivalent to placeholder
                                                                                                                                              #     character, use placeholder character. Otherwise use the letter.
    return position                                                                                                                           # Returns the variable as a string.
  end


  # METHOD TO CREATE THE WORD SEARCH PUZZLE AND RETURN IT AS A STRING
  #-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def make_puzzle
    @words.each { | word | letters << word.split( "" ) }                            # Takes each word, strips the individual letters from the word, and places the letters into an array
    @letters.flatten!.uniq!.sort!                                                   # Removes any duplicate letters from the array. These letters will be used to fill in the space
                                                                                    # around the word search words

    @words.each { | word |                                                          # Takes each word from words array
      usable_directions = [ 0, 1, 2, 3, 4, 5, 6, 7 ]                                # Array of the 8 possible directions. 0 = N, 1 = NE, 2 = E, 3 = SE, 4 = S, 5 = SW, 6 = W, 7 = NW
      direction = rand( usable_directions.length )                                  # Randomly selects one of the 8 possible directions
      placed = false                                                                # Initial variable stating the word has not been placed on the grid
      row = rand( @grid_size )                                                      # Randomly selects a row on the grid
      col = rand( @grid_size )                                                      # Randomly selects a column on the grid
      x = row                                                                       # Copies row to another variable, x
      y = col                                                                       # Copies col to another variable, y
      while placed == false                                                         # Do loop while the word has not been placed on the grid
        if @test_grid[ row ][ col ] == nil                                          # Check to see if the row, column position has been used or not
          if check_fit( direction, x, y, word ) == true                             # Calls a method to see if the word will fit on the grid, starting at the x, y position
            place_word( direction, row, col, word )                                 # If the word fits from the previous method, then this method will place the word on the answer grid
            @test_grid = Array.new( @grid_size ) { Array.new( @grid_size ) }        # Erases and creates a new test grid
            placed = true                                                           # Lets the loop know that the word has been placed
          else
            usable_directions.delete_at( direction )                                # If the word doesn't fit on the grid with the selected direction, then it removes that direction and randomly chooses another direction
            if usable_directions.length > 0                                         # Chose another direction if there are still available directions to choose from
              direction = rand( usable_directions.length )                          # Randomly chooses another direction from the array of available directions
            else
              @test_grid[ row ][ col ] = true                                       # If there are no usable directions to place the word, mark current position on test grid as unusable
              usable_directions = [ 0, 1, 2, 3, 4, 5, 6, 7 ]                        # Reset the array of 8 possible directions to choose from
              direction = rand( usable_directions.length )                          # Randomly choose a direction to place the word
              row = rand( @grid_size )                                              # Randomly choose a row on the puzzle grid
              col = rand( @grid_size )                                              # Randomly choose a column on the puzzle grid
              x = row                                                               # Copies row to variable x
              y = col                                                               # Copies col to variable y
            end
          end
        else                                                                        # If the position on the test grid has already been tried then chose another position
          row = rand( @grid_size )                                                  # Randomly chooses a new row position
          col = rand( @grid_size )                                                  # Randomly chooses a new column position
          x = row                                                                   # Copies row to x variable
          y = col                                                                   # Copies column to y variable
        end
      end
    }

    position = ""                                                                                                                                               # Creates a string variable to store the created puzzle
    @puzzle_grid.each { | row | row.each { | col | position += col == @placeholder_char ? @letters[ rand( @letters.length ) ] : col }; position += "\n" }       # If the current puzzle grid position contains a placeholder
                                                                                                                                                                #     character, randomly choose a letter to fill in the puzzle.
                                                                                                                                                                # Otherwise, if the current puzzle grid position contains a
                                                                                                                                                                #     letter from a word, use the word and not a fill letter
    return position                                                                                                                                             # Returns the completed puzzle
  end


  # METHOD TO SEE IF THE SELECTED WORD WILL FIT ON THE PUZZLE GRID WITH A GIVEN PRINTED DIRECTION
  #------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def check_fit( direction, x, y, word )
    position = 0                                                                                                      # Initial position setting for slicing letters from the word
    case direction                                                                                                    # Case select for the 8 different directions
      when 0                                                                                                          # If the direction is 0 ( word is printed N )
        if ( x - word.length ) > 0                                                                                    # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              x -= 1                                                                                                  # Moves the current position to the previous row ( N )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing N )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( N ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( N )
        end

      when 1                                                                                                          # If the direction is 1 ( word is printed NE )
        if ( x - word.length ) > 0 && ( y + word.length ) < @grid_size                                                # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              x -= 1                                                                                                  # Moves the current position to the previous row ( N )
              y += 1                                                                                                  # Moves the current position to the next column ( E )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing NE )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( NE ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( NE )
        end

      when 2                                                                                                          # If the direction is 2 ( word is printed E )
        if ( y + word.length ) < @grid_size                                                                           # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              y += 1                                                                                                  # Moves the current position to the next column ( E )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing E )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( E ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( E )
        end

      when 3                                                                                                          # If the direction is 3 ( word is printed SE )
        if ( y + word.length ) < @grid_size && ( x + word.length ) < @grid_size                                       # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              x += 1                                                                                                  # Moves the current position to the next row ( S )
              y += 1                                                                                                  # Moves the current position to the next column ( E )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing SE )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( SE ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( SE )
        end

      when 4                                                                                                          # If the direction is 4 ( word is printed S )
        if ( x + word.length ) < @grid_size                                                                           # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              x += 1                                                                                                  # Moves the current position to the next row ( S )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing S )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( S ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( S )
        end

      when 5                                                                                                          # If the direction is 5 ( word is printed SW )
        if ( x + word.length ) < @grid_size && ( y - word.length ) > 0                                                # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              x += 1                                                                                                  # Moves the current position to the next row ( S )
              y -= 1                                                                                                  # Moves the current position to the previous column ( W )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing SW )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( SW ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( SW )
        end

      when 6                                                                                                          # If the direction is 6 ( word is printed W )
        if ( y - word.length ) > 0                                                                                    # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              y -= 1                                                                                                  # Moves the current position to the previous column ( W )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing W )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( W ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( W )
        end

      when 7                                                                                                          # If the direction is 7 ( word is printed NW )
        if ( x - word.length ) > 0 && ( y - word.length ) > 0                                                         # Checks to see if the word will fit on the puzzle grid
          while position < word.length                                                                                # If word will fit on puzzle grid, counter starts at the first letter and continues until end of the word
            if @answer_grid[ x ][ y ] == @placeholder_char || @answer_grid[ x ][ y ] == word.slice( position )        # Checks to see if the sliced letter will be place on a usable position on the puzzle grid. Usable position
                                                                                                                      #     is a placeholder character or the same letter
              position += 1                                                                                           # Increment counter to the next letter in the word
              x -= 1                                                                                                  # Moves the current position to the previous row ( N )
              y -= 1                                                                                                  # Moves the current position to the previous column ( W )
            else                                                                                                      # If the position on the grid doesn't contain a placeholder character or the same letter
              return false                                                                                            #     it returns false. The word will not fit on the puzzle grid using this direction ( printing NW )
            end
          end                                                                                                         # If the word successfully fits on the puzzle grid with this direction ( NW ) it returns true so
          return true                                                                                                 #     the program knows to place the word at this location and print it in this direction ( NW )
        end
    end
  end


  # METHOD TO PLACE THE WORD ON THE ANSWER GRID
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def place_word( direction, row, col, word )
    position = 0                                                    # Initial position setting for slicing letters from the word
    case direction                                                  # Case select for the 8 different directions
      when 0                                                        # If the direction is 0 ( word is printed N )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          row -= 1                                                  # Moves the current position to the previous row ( N )
        end

      when 1                                                        # If the direction is 1 ( word is printed NE )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          row -= 1                                                  # Moves the current position to the previous row ( N )
          col += 1                                                  # Moves the current position to the next column ( E )
        end

      when 2                                                        # If the direction is 2 ( word is printed E )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          col += 1                                                  # Moves the current position to the next column ( E )
        end

      when 3                                                        # If the direction is 3 ( word is printed SE )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          row += 1                                                  # Moves the current position to the next row ( S )
          col += 1                                                  # Moves the current position to the next column ( E )
        end

      when 4                                                        # If the direction is 4 ( word is printed S )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          row += 1                                                  # Moves the current position to the next row ( S )
        end

      when 5                                                        # If the direction is 5 ( word is printed SW )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          row += 1                                                  # Moves the current position to the next row ( S )
          col -= 1                                                  # Moves the current position to the previous column ( W )
        end

      when 6                                                        # If the direction is 6 ( word is printed W )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          col -= 1                                                  # Moves the current position to the previous column ( W )
        end

      when 7                                                        # If the direction is 7 ( word is printed NW )
        while position < word.length                                # Starts at the first letter of the word and continues to get each letter until the last letter of the word
          @answer_grid[ row ][ col ] = word.slice( position )       # Places the letter onto the answer grid
          position += 1                                             # Increment counter to get the next letter in the word
          row -= 1                                                  # Moves the current position to the previous row ( N )
          col -= 1                                                  # Moves the current position to the previous column ( W )
        end
    end
  end


  # OVERRIDES THE BUILT-IN to_s METHOD. RETURNS THE DETAILS OF THE WORD SEARCH PUZZLE
  #--------------------------------------------------------------------------------------------------------------------------------------------------
  def to_s
    details = "Word Search Puzzle Details\n"                                      # String variable containing the title
    details += "\tNumber of Words:\t\t#{ @words.length }\n"                       # The number of words to find in the word search
    details += "\tPuzzle Grid Size:\t\t#{ @grid_size } x #{ @grid_size }\n"       # The size of the word search puzzle
    details += "\tWords File Name:\t\t#{ @file_name }\n"                          # The file name containing the word search words
    details += "\tPlaceholder Character:\t#{ @placeholder_char }\n"               # The character used as the placeholder character in the answer key
    return details
  end
end