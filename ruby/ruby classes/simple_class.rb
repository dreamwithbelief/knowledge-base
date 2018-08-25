############################################################
#
#  Name:        Kyle Stafford
#  Date:        04/16/2012
#  Class:       CIS 283
#  Assignment:  Simple Classes
#  Description: A program that simulates the operation
#               of a DVD player.
#
############################################################

#  Class named Player
#-----------------------------------------------------------
class Player
  attr_accessor( :has_disk, :disk_playing, :start_time, :current_position )
  def initialize( has_disk, disk_playing )
    @has_disk = has_disk
    @disk_playing = disk_playing
    @start_time = 0
    @elapsed_time = 0
    @current_position = 0
  end

  def insert_disk
    if @has_disk == true
      msg = "\nThere is already a disk in the player!\n\n"
    else
      msg = "\nDisk successfully inserted!\n\n"
      @has_disk = true
    end
    return msg
  end

  def play
    if @has_disk == true
      if @disk_playing == false
        msg = "\nDisk is now playing!\n\n"
        @disk_playing = true
        @start_time = Time.now
        position
      else
        msg = "\nDisk is already playing!\n\n"
      end
    else
      msg = "\nThere is no disk in player to play!\n\n"
    end
    return msg
  end

  def stop
    if @has_disk == true
      if @disk_playing == true
        msg = "\nDisk is now stopped!\n\n"
        @elapsed_time += position
        @disk_playing = false
      else
        msg = "\nDisk has already stopped!\n\n"
      end
    else
      msg = "\nThere is no disk in player to stop!\n\n"
    end
    return msg
  end

  def fast_forward( seconds )
    if @has_disk == true
      if @current_position + seconds > 7200
        @current_position = 7200
      else
        @current_position += seconds
      end
      msg = "\nFast forward successful!\n\n"
    else
      msg = "\nThere is no disk in player to fast forward!\n\n"
    end
    return msg
  end

  def rewind( seconds )
    if @has_disk == true
      if @current_position - seconds < 0
        @current_position = 0
      else
        @current_position -= seconds
      end
      msg = "\nRewind successful!\n\n"
    else
      msg = "\nThere is no disk in player to rewind!\n\n"
    end
    return msg
  end

  def eject_disk
    if @has_disk == false
      msg = "\nThere is no disk to eject from player!\n\n"
    else
      msg = "\nDisk successfully ejected!\n\n"
      @has_disk = false
    end
    @disk_playing = false
    @current_position = 0
    return msg
  end

  def current_status
    return "\nDVD Player\n\tDisk Inserted: #{ @has_disk }\n\tDisk Playing: #{ @disk_playing }\n\tCurrent Disk Position: #{ position }\n\n"
  end

  def to_s
    current_status
  end

  def position
    if @disk_playing == true
      if @elapsed_time > 0
        @current_position = Time.now - @start_time + @elapsed_time
      else
        @current_position = Time.now - @start_time
      end
      return @current_position
    else
      return @elapsed_time
    end
  end
end

class Menu
  attr_reader( :quit )
  def initialize( *menu_args )
    @menu_items = menu_args
    @quit = @menu_items.count
  end

  def get_menu_choice
    @menu_items.each_with_index do | item, index |
      puts "#{ index + 1 }. #{ item }"
    end
    print "Please enter your choice: "
    return gets.to_i
  end
end

menu = Menu.new( "Insert Disk", "Play Disk", "Rewind Disk", "Fast Forward Disk", "Stop Disk", "Eject Disk", "Current Disk Status", "Quit" )
dvd = Player.new( false, false )

while ( choice = menu.get_menu_choice ) != menu.quit
  case choice
    when 1
      puts dvd.insert_disk
    when 2
      puts dvd.play
    when 3
      print "\nHow many seconds to rewind disk?: "
      seconds = gets.to_i
      puts dvd.rewind( seconds )
    when 4
      print "\nHow many seconds to fast forward disk?: "
      seconds = gets.to_i
      puts dvd.fast_forward( seconds )
    when 5
      puts dvd.stop
    when 6
      puts dvd.eject_disk
    when 7
      puts dvd.current_status
  end
end