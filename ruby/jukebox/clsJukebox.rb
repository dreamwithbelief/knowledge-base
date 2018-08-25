############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/01/2012
#  Class:       CIS 283
#  Assignment:  Jukebox
#  Description: Jukebox Class for Jukebox assignment.
#
############################################################

class Jukebox
  attr_accessor( :playlist )
  def initialize
    @playlist = []
  end

  def song_details

  end

  def list_song_details( song )
    details = "1.\tTitle:\t\t#{ @playlist[ song ].title }\n"
    details += "2.\tArtist:\t\t#{ @playlist[ song ].artist }\n"
    details += "3.\tAlbum:\t\t#{ @playlist[ song ].album }\n"
    details += "4.\tYear:\t\t#{ @playlist[ song ].year }\n"
    details += "5.\tComments:\t#{ @playlist[ song ].comments }\n"
    details += "6.\tTime:\t\t#{ @playlist[ song ].time } seconds\n\n"
    return details
  end

  def play_song( song_choice )
    song = "\nNow Playing Song #{ song_choice }!\n"
    song += song_details( @playlist[ song_choice - 1 ] )
    return song
  end

  def all_songs
    details = "\nShow All Songs\n\n"
    @playlist.each_with_index { | song, index | details += ( "#{ index + 1 }.\t#{ song }\n" ) }
    return details
  end

  def all_songs_by_artist( artist_name )
    list = "\nDisplaying Songs By: #{ artist_name }\n\n"
    @playlist.each { | song |
      if song.artist.upcase == artist_name.upcase
        list += song_details( song )
      end
    }
    if list == "\nDisplaying Songs By: #{ artist_name }\n\n"
      list = "\nNo Songs Found By Artist: #{ artist_name }\n\n"
    end
    return list
  end

  def all_songs_by_length( time_in_seconds )
    list = "\nDisplaying Songs Longer Than: #{ time_in_seconds } seconds\n\n"
    @playlist.each { | song |
      if song.time > time_in_seconds
        list += song_details( song )
      end
    }
    if list == "\nDisplaying Songs Longer Than: #{ time_in_seconds } seconds\n\n"
      list = "\nNo Songs Longer Than: #{ time_in_seconds } seconds\n\n"
    end
    return list
  end

  def add_song( song )
    @playlist << song
  end

  def update_song( song, song_choice )
    @playlist[ song_choice - 1 ] = Song.new( song[0], song[1], song[2], song[3].to_i, song[4], song[5].to_i )
  end

  def delete_song( song_choice )
    @playlist.delete_at( song_choice - 1 )
  end
end