class Menu
  attr_reader( :quit )
  def initialize( menu_arguments )
    @prompt = menu_arguments.delete( :prompt )
    @menu_items = menu_arguments.to_a
    @quit = @menu_items.count
  end

  def get_menu_choice
    choice = 0
    while choice != @quit
      @menu_items.each_with_index { | item, index | puts "#{ index + 1 }.\t#{ item[1] }" }
      print @prompt
      choice = gets.to_i
      if( choice > @quit || choice <= 0 )
        puts "\nPlease enter a valid menu choice!\n\n"
      else
        puts "\n" + @menu_items[ choice - 1 ][1] + "\n\n"
        method( @menu_items[ choice - 1 ][ 0 ] ).call
      end
    end
  end
end