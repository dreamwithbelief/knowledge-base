############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/09/2012
#  Class:       CIS 283
#  Assignment:  Character Playoff
#  Description: Class for the die.
#               Allows two different fictional characters to
#               face off against each other in a simulated
#               environment.
#
############################################################

class Dice
  attr_accessor( :num_sides )
  def initialize( num_sides )
    @num_sides = num_sides.to_i
  end

  def roll
    return rand(1..@num_sides)
  end
end