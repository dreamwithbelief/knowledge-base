############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/01/2012
#  Class:       CIS 283
#  Assignment:  Jukebox
#  Description: Song Class for Jukebox assignment.
#
############################################################

class Song
  attr_accessor( :title, :artist, :album, :year, :comments, :time )
  def initialize( title, artist, album, year, comments, time )
    @title = title
    @artist = artist
    @album = album
    @year = year
    @comments = comments
    @time = time
  end

  def to_s
    return "#{ @title }\t#{ @artist }\t#{ @album }\t#{ @year }\t#{ @comments }\t#{ @time }"
  end
end