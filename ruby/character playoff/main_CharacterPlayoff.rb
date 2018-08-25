############################################################
#
#  Name:        Kyle Stafford
#  Date:        05/09/2012
#  Class:       CIS 283
#  Assignment:  Character Playoff
#  Description: Main program for Character Playoff.
#               Allows two different fictional characters to
#               face off against each other in a simulated
#               environment.
#
############################################################

character_names = []                              # Array to hold character name
characters = []                                   # Array to hold the characters loaded from their flat file
Dir.foreach( "characters" ) { | file |
  element = file.split(".")                       # Loads the file name from the characters directory and strips
  character_names << element[0]                   # everything but the name. Puts the name into the character_names array
}
character_names.compact!                          # Removes any nil values in the array

require_relative( "clsMenu" )                     # File containing the Menu class
require_relative( "clsCharacter" )                # File containing the Character class
require_relative( "clsWeapon" )                   # File containing the Weapon class
require_relative( "clsArmor" )                    # File containing the Armor class
require_relative( "clsDice" )                     # File containing the Dice class


# Method to list available characters to load
#--------------------------------------------------
def list_character( choice, character_names )
  char_list = "\n-Load Character #{ choice }-\n\n"
  character_names.each_with_index{ | character, index | char_list += "#{ index + 1 }.\t#{ character }\n" }
  char_list += "Choose A Character: "
  return char_list
end

# Method to load user selected character into memory
#--------------------------------------------------
def load_character( character_choice, character_list )
  character_file = File.open( "characters/#{ character_list[ character_choice - 1 ] }.txt" )
  char = character_file.readline.chomp.split( "," )
  wep = character_file.readline.chomp.split( "," )
  arm = character_file.readline.chomp.split( "," )
  weapon = Weapon.new( wep[ 0 ], wep[ 1 ] )
  armor = Armor.new( arm[ 0 ], arm[ 1 ] )
  character_file.close
  return Character.new( char[ 0 ], char[ 1 ], char[ 2 ], char[ 3 ], char[ 4 ], weapon, armor )
end

# Displays the user menu
#--------------------------------------------------
menu = Menu.new( "Load Character 1",
                 "Load Character 2",
                 "Fight",
                 "Quit" )

while (choice = menu.get_menu_choice) != menu.quit
  case choice
    # Load character 1 menu option
    #--------------------------------------------------
    when 1
      print list_character( choice, character_names )
      character_choice = gets.to_i

      # If user enters an incorrect character selection option
      #-------------------------------------------------------
      while character_choice <= 0 || character_choice > character_names.length
        puts "\nPlease enter a valid character choice!\n"
        print list_character( choice, character_names )
        character_choice = gets.to_i
      end

      # Loads user selected character into Character 1 slot
      #----------------------------------------------------
      characters[ 0 ] = load_character( character_choice, character_names )
      characters[ 0 ].current_hp = characters[ 0 ].hp
      puts "\n#{ character_names[ character_choice - 1 ] } was successfully loaded!\n\n"

    # Load character 2 menu option
    #--------------------------------------------------
    when 2
      print list_character( choice, character_names )
      character_choice = gets.to_i

      # If user enters an incorrect character selection option
      #-------------------------------------------------------
      while character_choice <= 0 || character_choice > character_names.length
        puts "\nPlease enter a valid character choice!\n"
        print list_character( choice, character_names )
        character_choice = gets.to_i
      end

      # Loads user selected character into Character 2 slot
      #----------------------------------------------------
      characters[ 1 ] = load_character( character_choice, character_names )
      characters[ 1 ].current_hp = characters[ 1 ].hp
      puts "\n#{ character_names[ character_choice - 1 ] } was successfully loaded!\n\n"

    # Fight menu option
    #--------------------------------------------------
    when 3
      # Display error if user has not loaded 2 characters to fight
      #-----------------------------------------------------------
      if characters.length < 2
        puts "\nPlease Load Characters To Fight!\n\n"
      else
        puts "\n-Fight-\n\n"
        player1_die = Dice.new( characters[ 0 ].agility )
        player2_die = Dice.new( characters[ 1 ].agility )
        d2 = Dice.new( 2 )
        d4 = Dice.new( 4 )
        d8 = Dice.new( 8 )
        d10 = Dice.new( 10 )
        d15 = Dice.new( 15 )

        while characters[ 0 ].current_hp > 0 && characters[ 1 ].current_hp > 0
          if player1_die.roll > player2_die.roll
            puts characters[ 0 ].name + " attacks first!"
            if d10.roll < player1_die.roll
              hit, armor_save = characters[1].reduce_hp( characters[ 0 ], characters[ 1 ], d4, d8, d15 )
              puts "#{ characters[ 0 ].name} Inflicted: #{ hit } Damage"
              puts "#{ characters[ 1 ].name} Armor Saved: #{ armor_save } Points"

              if characters[ 1 ].current_hp < 0
                characters[ 1 ].current_hp = 0
                puts "#{ characters[ 1 ].name } has died! #{ characters[ 0 ].name } wins!"
              else
                puts "#{ characters[ 1 ].name } #{ characters[ 1 ].current_status }"
              end
            else
              if characters[ 0 ].current_hp != 0
                puts characters[ 0 ].name + " misses!"
              end
            end

            if d10.roll < player2_die.roll
              hit, armor_save = characters[0].reduce_hp( characters[ 1 ], characters[ 0 ], d4, d8, d15 )
              puts "#{ characters[ 1 ].name} Inflicted: #{ hit } Damage"
              puts "#{ characters[ 0 ].name} Armor Saved: #{ armor_save } Points"

              if characters[ 0 ].current_hp < 0
                characters[ 0 ].current_hp = 0
                puts "#{ characters[ 0 ].name } has died! #{ characters[ 1 ].name } wins!"
              else
                puts "#{ characters[ 0 ].name } #{ characters[ 0 ].current_status }"
              end
            else
              if characters[ 1 ].current_hp != 0
                puts characters[ 1 ].name + " misses!"
              end
            end
            pause = gets
          end

          if player2_die.roll > player1_die.roll
            puts characters[ 1 ].name + " attacks first!"
            if d10.roll < player2_die.roll
              hit, armor_save = characters[0].reduce_hp( characters[ 1 ], characters[ 0 ], d4, d8, d15 )
              puts "#{ characters[ 1 ].name} Inflicted: #{ hit } Damage"
              puts "#{ characters[ 0 ].name} Armor Saved: #{ armor_save } Points"

              if characters[ 0 ].current_hp < 0
                characters[ 0 ].current_hp = 0
                puts "#{ characters[ 0 ].name } has died! #{ characters[ 1 ].name } wins!"
              else
                puts "#{ characters[ 0 ].name } #{ characters[ 0 ].current_status }"
              end
            else
              if characters[ 1 ].current_hp != 0
                puts characters[ 1 ].name + " misses!"
              end
            end

            if d10.roll < player1_die.roll
              hit, armor_save = characters[1].reduce_hp( characters[ 0 ], characters[ 1 ], d4, d8, d15 )
              puts "#{ characters[ 0 ].name} Inflicted: #{ hit } Damage"
              puts "#{ characters[ 1 ].name} Armor Saved: #{ armor_save } Points"

              if characters[ 1 ].current_hp < 0
                characters[ 1 ].current_hp = 0
                puts "#{ characters[ 1 ].name } has died! #{ characters[ 0 ].name } wins!"
              else
                puts "#{ characters[ 1 ].name } #{ characters[ 1 ].current_status }"
              end
            else
              if characters[ 0 ].current_hp != 0
                puts characters[ 0 ].name + " misses!"
              end
            end
            pause = gets
          end
        end
        characters.each { | character | character.revive_character }
      end
    else
      puts "\nPlease enter a valid menu choice!\n\n"
  end
end