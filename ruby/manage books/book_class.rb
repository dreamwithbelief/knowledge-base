############################################################
#
#  Name:        Kyle Stafford
#  Date:        04/25/2012
#  Class:       CIS 283
#  Assignment:  Books Class
#  Description: Separate file to have the class Book
#
############################################################

class Book
  attr_accessor( :title, :author, :pages )
  def initialize( title, author, pages )
    @title = title
    @author = author
    @pages = pages.to_i
  end

  def to_s
    return "#{ @title }\t#{ @author }\t#{ @pages }"
  end
end