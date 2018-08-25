############################################################
#
#  Name:        Kyle Stafford
#  Date:        04/09/2012
#  Class:       CIS 283
#  Assignment:  Ruby Classes
#  Description: A program that uses three different classes
#               in Ruby, named Person, Address, and Character.
#
############################################################

#  Class named Person
#-----------------------------------------------------------
class Person
  def initialize( first_name, last_name, age, hair_color, eye_color )

    #  Define instance variables
    #-------------------------------
    @first_name = first_name
    @last_name = last_name
    @age = age
    @hair_color = hair_color
    @eye_color = eye_color


    #  Get and Set for @first_name
    #-------------------------------
    def first_name
      return @first_name
    end

    def first_name=( first_name )
      @first_name = first_name
    end


    #  Get and Set for @last_name
    #-------------------------------
    def last_name
      return @last_name
    end

    def last_name=( last_name )
      @last_name = last_name
    end


    #  Get and Set for @age
    #-------------------------------
    def age
      return @age
    end

    def age=( age )
      @age = age
    end


    #  Get and Set for @hair_color
    #-------------------------------
    def hair_color
      return @hair_color
    end

    def hair_color=( hair_color )
      @hair_color = hair_color
    end


    #  Get and Set for @eye_color
    #-------------------------------
    def eye_color
      return @eye_color
    end

    def eye_color=( eye_color )
      @eye_color = eye_color
    end

    #  Override to_s method for
    #  Person class
    #-------------------------------
    def to_s
      return "Object of the Person class. Contains the following values: \n\tFirst Name: #{@first_name}\n\tLast Name: #{@last_name}\n\tAge: #{@age}\n\tHair Color: #{@hair_color}\n\tEye Color: #{@eye_color}"
    end
  end
end


#  Class named Address
#-----------------------------------------------------------
class Address
  def initialize( line1, line2, city, state, zip )

    #  Define instance variables
    #-------------------------------
    @line1 = line1
    @line2 = line2
    @city = city
    @state = state
    @zip = zip


    #  Get and Set for @line1
    #-------------------------------
    def line1
      return @line1
    end

    def line1=( line1 )
      @line1 = line1
    end


    #  Get and Set for @line2
    #-------------------------------
    def line2
      return @line2
    end

    def line2=( line2 )
      @line2 = line2
    end


    #  Get and Set for @city
    #-------------------------------
    def city
      return @city
    end

    def city=( city )
      @city = city
    end


    #  Get and Set for @state
    #-------------------------------
    def state
      return @state
    end

    def state=( state )
      @state = state
    end


    #  Get and Set for @zip
    #-------------------------------
    def zip
      return @zip
    end

    def zip=( zip )
      @zip = zip
    end

    #  Override to_s method for
    #  Address class
    #-------------------------------
    def to_s
      return "Object of the Address class. Contains the following values: \n\tAddress Line 1: #{@line1}\n\tAddress Line 2: #{@line2}\n\tCity: #{@city}\n\tState: #{@state}\n\tZip Code: #{@zip}"
    end
  end
end


#  Class named Character
#-----------------------------------------------------------
class Character
  def initialize( name, race, hit_points, weapons, clothing, gold )

    #  Define instance variables
    #-------------------------------
    @name = name
    @race = race
    @hit_points = hit_points
    @weapons = weapons
    @clothing = clothing
    @gold = gold


    #  Get and Set for @name
    #-------------------------------
    def name
      return @name
    end

    def name=( name )
      @name = name
    end


    #  Get and Set for @race
    #-------------------------------
    def race
      return @race
    end

    def race=( race )
      @race = race
    end


    #  Get and Set for @hit_points
    #-------------------------------
    def hit_points
      return @hit_points
    end

    def hit_points=( hit_points )
      @hit_points = hit_points
    end


    #  Get and Set for @weapons
    #-------------------------------
    def weapons
      return @weapons
    end

    def weapons=( weapons )
      @weapons = weapons
    end


    #  Get and Set for @gold
    #-------------------------------
    def clothing
      return @clothing
    end

    def clothing=( clothing )
      @clothing = clothing
    end


    #  Get and Set for @gold
    #-------------------------------
    def gold
      return @gold
    end

    def gold=( gold )
      @gold = gold
    end


    #  Add weapon
    #-------------------------------
    def add_weapon( weapon_name )
      @weapons << weapon_name
    end


    #  Drop weapon
    #-------------------------------
    def drop_weapon( weapon_index )
      @weapons.delete_at( weapon_index - 1 )
    end


    #  Add clothing
    #-------------------------------
    def add_clothing( clothing_name )
      @clothing << clothing_name
    end


    #  Drop clothing
    #-------------------------------
    def drop_clothing( clothing_index )
      @clothing.delete_at( clothing_index - 1 )
    end


    #  Override to_s method for
    #  Character class
    #-------------------------------
    def to_s
      return "Object of the Character class. Contains the following values: \n\tName: #{@name}\n\tRace: #{@race}\n\tHit Points: #{@hit_points}\n\tWeapons:\n\t\t#{@weapons.join("\n\t\t")}\n\tClothes:\n\t\t#{@clothing.join("\n\t\t")}\n\tGold: #{@gold}"
    end
  end
end

def menu ( menu_name )
  menu_name.each { | key, value | puts "#{key}. #{value}" }
  print "Please enter your choice: "
  return gets.to_i
end

MENU_ITEMS = { 1 => "Person Class", 2 => "Address Class", 3 => "Character Class", 4=> "Exit" }
MENU_CHARACTER = { 1 => "Weapons Menu", 2 => "Clothing Menu", 3 => "Back to Main Menu" }
MENU_WEAPONS = { 1 => "Add Weapon", 2 => "Drop Weapon", 3 => "Back to Character Menu" }
MENU_CLOTHING = { 1 => "Add Clothing", 2 => "Drop Clothing", 3 => "Back to Character Menu" }

hit_points = 250
weapons = [ "Dagger", "Sword", "War Axe", "Mace" ]
clothes = [ "Embellished Robe", "Embroidered Garment", "Emperor's Robes", "Fine Raiment", "Fur-Trimmed Cloak", "Noble Clothes", "Psiijic Clothes", "Refined Tunic" ]
gold = 10000

while ( selection = menu( MENU_ITEMS ) ) != MENU_ITEMS.length
  if( selection > MENU_ITEMS.length || selection <= 0 )
    puts "Please enter a valid menu choice!"
  else
    puts
    puts MENU_ITEMS[ selection ]
    if selection == 1
      print "Enter your first name: "
      first_name = gets.chomp
      print "Enter your last name: "
      last_name = gets.chomp
      print "Enter your age: "
      age = gets.to_i
      print "Enter your hair color: "
      hair_color = gets.chomp
      print "Enter your eye color: "
      eye_color = gets.chomp

      me = Person.new( first_name, last_name, age, hair_color, eye_color )
      puts
      puts me
      puts
    end
    if selection == 2
      print "Enter first line of your address: "
      line1 = gets.chomp
      print "Enter second line of your address: "
      line2 = gets. chomp
      print "Enter the city: "
      city = gets.chomp
      print "Enter the state: "
      state = gets.chomp
      print "Enter the zip code: "
      zip = gets.chomp

      home = Address.new( line1, line2, city, state, zip )
      puts
      puts home
      puts
    end
    if selection == 3
      print "Enter your character's name: "
      name = gets.chomp
      print "Enter your character's race: "
      race = gets.chomp

      player1 = Character.new( name, race, hit_points, weapons, clothes, gold )
      puts
      puts player1
      puts

      while ( selection_character = menu( MENU_CHARACTER ) ) != MENU_CHARACTER.length
        if ( selection_character > MENU_CHARACTER.length || selection_character <= 0 )
          puts "Please enter a valid menu choice!"
        else
          puts
          puts MENU_CHARACTER[ selection_character ]
          if selection_character == 1
            while ( selection_weapon = menu( MENU_WEAPONS ) ) != MENU_WEAPONS.length
              if ( selection_weapon > MENU_WEAPONS.length || selection_weapon <= 0 )
                puts "Please enter a valid menu choice!"
              else
                puts
                puts MENU_WEAPONS[ selection_weapon ]
                if selection_weapon == 1
                  print "Enter Weapon Name: "
                  weapon_name = gets.chomp
                  player1.add_weapon( weapon_name )
                  puts
                  puts player1
                  puts
                end

                if selection_weapon == 2
                  counter = 1
                  weapons.each do | weapon |
                    puts "#{counter}. #{weapon}"
                    counter += 1
                  end
                  weapon_index = gets.to_i
                  player1.drop_weapon( weapon_index )
                  puts
                  puts player1
                  puts
                end
              end
            end
          end

          if selection_character == 2
            while ( selection_clothing = menu( MENU_CLOTHING ) ) != MENU_CLOTHING.length
              if ( selection_clothing > MENU_CLOTHING.length || selection_clothing <= 0 )
                puts "Please enter a valid menu choice!"
              else
                puts
                puts MENU_CLOTHING[ selection_clothing ]
                if selection_clothing == 1
                  print "Enter Clothing Name: "
                  clothing_name = gets.chomp
                  player1.add_clothing( clothing_name )
                  puts
                  puts player1
                  puts
                end

                if selection_clothing == 2
                  counter = 1
                  clothes.each do | item |
                    puts "#{counter}. #{item}"
                    counter += 1
                  end
                  item_index = gets.to_i
                  player1.drop_clothing( item_index )
                  puts
                  puts player1
                  puts
                end
              end
            end
          end
        end

        puts
      end

      puts
    end
  end
end