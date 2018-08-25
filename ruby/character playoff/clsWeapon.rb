############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/09/2012
#  Class:       CIS 283
#  Assignment:  Character Playoff
#  Description: Class for the weapon.
#               Allows two different fictional characters to
#               face off against each other in a simulated
#               environment.
#
############################################################

class Weapon
  attr_accessor( :name, :hit_points )
  def initialize( name, hit_points )
    @name = name
    @hit_points = hit_points.to_i
  end

  def to_s
    details = "Name:\t\t\t#{ @name }\n"
    details += "Hit Points:\t\t#{ @hit_points }\n"
    return details
  end
end