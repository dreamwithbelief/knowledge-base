############################################################
#
#  Name:        Kyle Stafford
#  Date:        06/07/2012
#  Class:       CIS 283
#  Assignment:  Word Search
#  Description: Main program for Word Search.
#               Program creates a word search from a text
#               file of words. Word search words are placed
#               randomly on the search grid.
#
############################################################

require_relative( "clsPuzzle" )       # Required file. Puzzle class
require( "prawn" )                    # Required to create the pdf


# ASK USER TO ENTER A PUZZLE SIZE
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
print "- Word Search Puzzle - \nEnter the size of puzzle to create.\n\t( Example: 45 would create a puzzle 45x45 )\n\t( Press Enter to use the default size of 45 )\nEnter puzzle size: "

size = gets.chomp                   # Gets user's puzzle size
size = size == "" ? 45 : size       # If user presses "Enter" default puzzle size is used, otherwise user defined size is used.


# ASK USER TO ENTER A PLACEHOLDER CHARACTER FOR THE WORD SEARCH ANSWER KEY
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
print "\nEnter a placeholder character to be used in the answer key.\n\t( Example: . would use a period as placeholder character )\n\t( Press Enter to use the default character period )\nEnter placeholder character: "

character = gets.chomp                                        # Gets user's placeholder character for answer key
character = character == "" ? "." : character                 # If user presses "Enter" default placeholder character is used, otherwise user defined character is used.

timer = Time.now                                              # Create timer to see how long it takes
                                                              #     to create puzzle and create puzzle with pdf

word_search = Puzzle.new( "words.txt", size, character )      # Creates new word search puzzle
                                                              # Required:
                                                              #     Name of text file containing the words for the puzzle
                                                              # Optional:
                                                              #     Grid size - Default 45
                                                              #     Answer key placeholder character - Default "."

puzzle = word_search.make_puzzle                              # Fills in letters around the puzzle words and puts it into a variable
answer_key = word_search.make_answer_key                      # Creates the Answer KEY for the puzzle by showing the location of
                                                              #     words surrounded by the placeholder characters

longest_word = word_search.words[ 0 ].length                  # Gets the length of the longest word. Used in formatting the columns of words


# PLACES THE WORDS TO FIND IN THE PUZZLE INTO 3 COLUMNS
#---------------------------------------------------------------------------------------------------------------------------------------------------------
words = ""
word_search.words.sort.each_with_index { | word, index | words += index % 3 != 2 ? word.ljust( 21 ) : word.ljust( longest_word ) + "\n" }


puts "\nWord Search Puzzle Creation Time:\t#{ Time.now - timer } seconds"                                   # Displays the time it took to create the
                                                                                                            #     word search puzzle in the console window

Prawn::Document.generate( 'KStafford_WordSearch.pdf', :margin => 36 ) do | pdf |                            # Creates new pdf document
  pdf.font "Courier"                                                                                        # Sets the font to be used in the pdf document
  pdf.text "Word Search", :align => :center, :size => 24                                                    # Title
  pdf.text puzzle, :character_spacing => 6, :align => :center, :size => 10                                  # Displays word search puzzle
  pdf.move_down 10                                                                                          # New line
  pdf.text "Find the following #{ word_search.words.length } words:", :align => :center, :size => 10        # Text displaying "Find the following words:"
  pdf.move_down 10                                                                                          # New line
  pdf.text words, :align => :center                                                                         # Centers and displays the words to find
  pdf.start_new_page                                                                                        # Creates new pdf page
  pdf.text "Answer KEY", :align => :center, :size => 24                                                     # Title
  pdf.text answer_key, :character_spacing => 6, :align => :center, :size => 10                              # Displays word search answer key
  pdf.move_down 10                                                                                          # New line
  pdf.text "Find the following #{ word_search.words.length } words:", :align => :center, :size => 10        # Text displaying "Find the following words:"
  pdf.move_down 10                                                                                          # New line
  pdf.text words, :align => :center                                                                         # Centers and displays the words to find
end

puts "Total Creation Time Including PDF:\t#{ Time.now - timer } seconds"                                    # Displays the time it took to create the word
                                                                                                            #     search puzzle including the pdf documents