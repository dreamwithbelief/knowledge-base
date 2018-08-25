############################################################
#
#  Name:        Kyle Stafford
#  Date:        04/05/2012
#  Class:       CIS 283
#  Assignment:  Validation
#  Description: Validate input from a user for a phone
#               number and an email address.
#
############################################################

#  Function to ask user for their phone number and gives
#  three examples of the acceptable format.
#-----------------------------------------------------------
def phone
  puts "Please enter your phone number using one of the following formats:"
  puts "(xxx) xxx-xxxx"
  puts "  xxx-xxx-xxxx"
  puts "  xxx.xxx.xxxx"
  print "Your phone number: "
end


#  Regular expression patterns for a phone number and
#  an email address.
#-----------------------------------------------------------
phone_number_regex = /\A(\(\d{3}\) \d{3}-|\d{3}(-\d{3}-|\.\d{3}\.))\d{4}\Z/
email_regex = /\A[a-z]+[\w+-]*((\.?|[\w+-])[\w+-])*@([\w-]+\.)+[a-z]{2,6}\Z/i


#  Ask user for their phone number.
#-----------------------------------------------------------
phone
phone_number = gets.chomp


#  Check to see if phone number is in correct format, if
#  not, ask user to re-enter phone number.
#-----------------------------------------------------------
valid_phone = false
while valid_phone == false
  if phone_number =~ phone_number_regex
    valid_phone = true
    puts "Thank you!"
    puts
  else
    puts "Invalid phone number!"
    puts
    phone
    phone_number = gets.chomp
  end
end


#  Ask user to enter their email address.
#-----------------------------------------------------------
print "Please enter your email address: "
email = gets.chomp


#  Check to see if email is in the correct format, if not,
#  ask user to re-enter their email address.
#-----------------------------------------------------------
valid_email = false
while valid_email == false
  if email =~ email_regex
    valid_email = true
    puts "Thank you!"
  else
    puts "Invalid email address!"
    puts
    print "Please enter your email address: "
    email = gets.chomp
  end
end