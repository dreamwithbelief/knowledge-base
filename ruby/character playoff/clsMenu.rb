############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/09/2012
#  Class:       CIS 283
#  Assignment:  Character Playoff
#  Description: Class for the menu.
#               Allows two different fictional characters to
#               face off against each other in a simulated
#               environment.
#
############################################################

class Menu
  attr_reader :quit
  def initialize( *menu_args )
    @menu_items = menu_args
    @quit = @menu_items.count
  end

  def get_menu_choice
    @menu_items.each_with_index { |item, index| puts "#{index + 1})\t#{item}" }
    print "Please enter your choice: "
    return gets.to_i
  end
end