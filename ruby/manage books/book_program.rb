############################################################
#
#  Name:        Kyle Stafford
#  Date:        04/25/2012
#  Class:       CIS 283
#  Assignment:  Books Class
#  Description: A program to manage book for Geek Publishing, Inc
#
############################################################

require_relative( "clsMenu")
require_relative( "stafford_week04_bookclass")

def view_all_books

end

def add_book

end

def update_book

end

def delete_book

end

def view_book_most_pages

end

def view_book_least_pages

end

def view_books_pages_greater_equal_1000

end

def view_books_pages_less_1000

end

def view_books_pages_between_500_1000_inclusive

end

books_list = []
books_file = File.open( "books_file.txt" )
books_file.each { | book | books_list << book.chomp.split( "\t" ) }
books_file.close

menu = Menu.new({:prompt => "Please enter your choice: ",
                 :view_all_books => "View All Books",
                 :add_book => "Add Book",
                 :update_book => "Update Book",
                 :delete_book => "Delete Book",
                 :view_book_most_pages => "View Book With Most Pages",
                 :view_book_least_pages => "View Book With Least Pages",
                 :view_books_pages_greater_equal_1000 => "View Books With Pages Greater Than or Equal to 1000",
                 :view_books_pages_less_1000 => "View Books With Pages Less Than 1000",
                 :view_books_pages_between_500_1000_inclusive => "View Books With Pages Between 500-1000 Inclusive",
                 :quit => "Exit"
                })
menu.get_menu_choice