############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/01/2012
#  Class:       CIS 283
#  Assignment:  Jukebox
#  Description: Main program for Jukebox assignment.
#               Allows a user to create a new song and fill
#               in the appropriate information. User can add,
#               update, delete, print/play a song, and exit.
#
############################################################

require_relative( "clsMenu" )
require_relative( "clsJukebox" )
require_relative( "clsSong" )



menu = Menu.new("Play Song",
                "Show All Songs",
                "Show Songs By Specific Artist",
                "Show Songs Longer Than Specific Time",
                "Add New Song",
                "Update Song",
                "Delete Song",
                "Quit")

myJukebox = Jukebox.new

songs_file = File.open( "songs.txt", "r" )
songs_file.each { | line | song = line.chomp.split( "\t" ); myJukebox.add_song( song ) }
songs_file.close

while (choice = menu.get_menu_choice) != menu.quit
  case choice
    when 1
      song_choice = 0
      while song_choice <= 0 || song_choice > myJukebox.playlist.length
        puts "\nPlay Song\n\n"
        print myJukebox.all_songs
        print "Chose A Song To Play: "
        song_choice = gets.to_i

        if song_choice <= 0 || song_choice > myJukebox.playlist.length
          puts "\nPlease enter a valid song to play!\n"
        else
          puts myJukebox.play_song( song_choice )
        end
      end

    when 2
      print myJukebox.all_songs

    when 3
      puts "\nShow Songs By Specific Artist\n"
      print "Enter Artist's Name: "
      artist_name = gets.chomp
      print myJukebox.all_songs_by_artist( artist_name )

    when 4
      puts "\nShow Songs Longer Than Specific Time\n"
      print "Enter Time In Seconds: "
      time_in_seconds = gets.chomp
      seconds_regex = /\A\d+\Z/

      while ( time_in_seconds =~ seconds_regex ) != 0
        puts "\nPlease enter a numeric value for time in seconds!"
        print "Enter Time In Seconds: "
        time_in_seconds = gets.chomp
      end

      print myJukebox.all_songs_by_length( time_in_seconds.to_i )

    when 5
      puts "\nAdd New Song\n\n"
      print "Enter Song Title: "
      title = gets.chomp
      print "Enter Artist Name: "
      artist = gets.chomp
      print "Enter Album Name: "
      album = gets.chomp
      print "Enter Album Year: "
      year = gets.chomp
      year_reg = /\A\d{4}\Z/
      while ( year =~ year_reg ) != 0
        puts "\nPlease enter a numeric value for the year!"
        print "Enter Album Year: "
        year = gets.to_i
      end
      print "Enter Comments: "
      comments = gets.chomp
      print "Enter Song Length In Seconds: "
      time = gets.chomp
      seconds_regex = /\A\d+\Z/
      while ( time =~ seconds_regex ) != 0
        puts "\nPlease enter a numeric value for time in seconds!"
        print "Enter Song Length In Seconds: "
        time = gets.to_i
      end
      myJukebox.add_song( Song.new( title, artist, album, year, comments, time ) )
      puts "\nSong Successfully Added!\n\n"

    when 6
      song_choice = 0
      while song_choice <= 0 || song_choice > myJukebox.playlist.length
        puts "\nUpdate Song\n\n"
        print myJukebox.all_songs
        print "Choose Song To Update: "
        song_choice = gets.to_i

        if song_choice <= 0 || song_choice > myJukebox.playlist.length
          puts "\nPlease enter a valid song to update!\n"
        else
          puts
          myJukebox.update_song( Song.song_info, song_choice )
          puts "\nSong Successfully Updated!\n\n"
        end
      end

    when 7
      song_choice = 0
      while song_choice <= 0 || song_choice > myJukebox.playlist.length
        puts "\nDelete Song\n\n"
        print myJukebox.all_songs
        print "Choose Song To Delete: "
        song_choice = gets.to_i

        if song_choice <= 0 || song_choice > myJukebox.playlist.length
          puts "\nPlease enter a valid song to delete!\n"
        end
      end

      myJukebox.delete_song( song_choice )
      puts "\nSong Successfully Deleted!\n\n"

    else
      puts "\nPlease enter a valid menu choice!\n\n"
  end
end

songs_file = File.open( "songs.txt", "w" )
myJukebox.playlist.each { | song | songs_file.puts song }
songs_file.close