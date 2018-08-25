############################################################
#
#  Name:        Kyle Stafford
#  Date:        1/26/2012
#  Class:       CIS 282
#  Assignment:  Rock, Paper, Scissors
#  Description: A game that will allow a user to play Rock,
#               Paper, Scissors against the computer. The
#               program will keep track of user wins, losses,
#               and ties.
#
############################################################

# Custom methods
def userWin
  $win += 1
  $games += 1
  $outcome = "Won!"
end

def userLost
  $loss += 1
  $games += 1
  $outcome = "Lost!"
end

def userTie
  $tie += 1
  $games += 1
  $outcome = "Tied!"
end

def playAgain
  puts
  puts
  puts "==================================================="
  puts "|  Would you like to play again?                  |"
  puts "|                                                 |"
  puts "|  1)  Yes                                        |"
  puts "|  2)  No, Go Back to Main Menu                   |"
  puts "|                                                 |"
  puts "==================================================="
  print "   Enter menu choice: "
end

def playAgainError
  puts
  puts
  puts "==================================================="
  puts "|       Please enter a valid menu choice.         |"
  puts "==================================================="
  puts "|  Would you like to play again?                  |"
  puts "|                                                 |"
  puts "|  1)  Yes                                        |"
  puts "|  2)  No, Go Back to Main Menu                   |"
  puts "|                                                 |"
  puts "==================================================="
  print "   Enter menu choice: "
end

def exitGame
  puts
  puts
  puts "==================================================="
  puts "|  Have a nice day! Goodbye                       |"
  puts "==================================================="

  exit
end

menu_choice = 0
$win = 0
$loss = 0
$tie = 0
$games = 0

# Ask user to play game
puts "==================================================="
puts "|  Would you like to play Rock, Paper, Scissors?  |"
puts "|                                                 |"
puts "|  1)  Yes                                        |"
puts "|  2)  No                                         |"
puts "|                                                 |"
puts "==================================================="
print "   Enter menu choice: "
menu_choice = gets.to_i

if menu_choice < 1 || menu_choice > 2
  while menu_choice < 1 || menu_choice > 2
    puts
    puts
    puts "==================================================="
    puts "|       Please enter a valid menu choice.         |"
    puts "==================================================="
    puts "|  Would you like to play Rock, Paper, Scissors?  |"
    puts "|                                                 |"
    puts "|  1)  Yes                                        |"
    puts "|  2)  No                                         |"
    puts "|                                                 |"
    puts "==================================================="
    print "   Enter menu choice: "
    menu_choice = gets.to_i
  end
end

# Play game
if menu_choice == 1
  menu_choice = 0

  while menu_choice == 0
    puts
    puts
    puts "==================================================="
    puts "|  Which version would you like to play?          |"
    puts "|                                                 |"
    puts "|  1)  Normal   - Rock, Paper, Scissors           |"
    puts "|                                                 |"
    puts "|  2)  Advanced - Rock, Paper, Scissors,          |"
    puts "|                 Lizard, Spock                   |"
    puts "|                                                 |"
    puts "|  3)  Game Rules for each version                |"
    puts "|                                                 |"
    puts "|  4)  Exit Game                                  |"
    puts "==================================================="
    print "   Enter menu choice: "
    menu_choice = gets.to_i

      while menu_choice < 1 || menu_choice > 4
        puts
        puts
        puts "==================================================="
        puts "|       Please enter a valid menu choice.         |"
        puts "==================================================="
        puts "|  Which version would you like to play?          |"
        puts "|                                                 |"
        puts "|  1)  Normal   - Rock, Paper, Scissors           |"
        puts "|                                                 |"
        puts "|  2)  Advanced - Rock, Paper, Scissors,          |"
        puts "|                 Lizard, Spock                   |"
        puts "|                                                 |"
        puts "|  3)  Game Rules for each version                |"
        puts "|                                                 |"
        puts "|  4)  Exit Game                                  |"
        puts "==================================================="
        print "   Enter menu choice: "
        menu_choice = gets.to_i
      end

    # Normal game version
    if menu_choice == 1
      rps = ["Rock","Paper","Scissors"]

      while menu_choice == 1
        computer_choice = rand(3)
        $outcome = ""

        puts
        puts
        puts "==================================================="
        puts "|  Choose Rock, Paper, or Scissors.               |"
        puts "|                                                 |"
        puts "|  1)  Rock                                       |"
        puts "|  2)  Paper                                      |"
        puts "|  3)  Scissors                                   |"
        puts "|                                                 |"
        puts "==================================================="
        print "   Enter menu choice: "
        user_choice = gets.to_i

        while user_choice < 1 || user_choice > 3
          puts
          puts
          puts "==================================================="
          puts "|       Please enter a valid menu choice.         |"
          puts "==================================================="
          puts "|  Choose Rock, Paper, or Scissors.               |"
          puts "|                                                 |"
          puts "|  1)  Rock                                       |"
          puts "|  2)  Paper                                      |"
          puts "|  3)  Scissors                                   |"
          puts "|                                                 |"
          puts "==================================================="
          print "   Enter menu choice: "
          user_choice = gets.to_i
        end

        case
          when computer_choice == 0 && user_choice == 1
            userTie
          when computer_choice == 0 && user_choice == 2
            userWin
          when computer_choice == 0 && user_choice == 3
            userLost
          when computer_choice == 1 && user_choice == 1
            userLost
          when computer_choice == 1 && user_choice == 2
            userTie
          when computer_choice == 1 && user_choice == 3
            userWin
          when computer_choice == 2 && user_choice == 1
            userWin
          when computer_choice == 2 && user_choice == 2
            userLost
          when computer_choice == 2 && user_choice == 3
            userTie
        end

        puts
        puts
        puts "==================================================="
        puts "|                  Game Result                    |"
        puts "==================================================="
        puts "   The computer chose #{rps[computer_choice]}"
        puts "   You chose #{rps[user_choice - 1]}"
        puts
        puts "   You #{$outcome}"
        puts
        puts "---------------------------------------------------"
        puts "|                Your Statistics                  |"
        puts "---------------------------------------------------"
        puts "   Wins   - #{$win}"
        puts "   Losses - #{$loss}"
        puts "   Ties   - #{$tie}"
        puts
        puts "   Total Games - #{$games}"
        puts "==================================================="
        print "   Press Enter key to continue... "
        pause = gets

        playAgain
        menu_choice = gets.to_i

        #
        if menu_choice < 1 || menu_choice > 2
          while menu_choice < 1 || menu_choice > 2
            playAgainError
            menu_choice = gets.to_i
          end
        end

        if menu_choice == 2
          menu_choice = 0
        end
      end
    end

    # Advanced game version
    if menu_choice == 2
      rpsls = ["Rock","Paper","Scissors", "Lizard", "Spock"]
      menu_choice = 1
      while menu_choice == 1
        computer_choice = rand(5)
        $outcome = ""

        puts
        puts
        puts "==================================================="
        puts "|  Choose Rock, Paper, Scissors, Lizard, Spock.   |"
        puts "|                                                 |"
        puts "|  1)  Rock                                       |"
        puts "|  2)  Paper                                      |"
        puts "|  3)  Scissors                                   |"
        puts "|  4)  Lizard                                     |"
        puts "|  5)  Spock                                      |"
        puts "|                                                 |"
        puts "==================================================="
        print "   Enter menu choice: "
        user_choice = gets.to_i

        if user_choice < 1 || user_choice > 5
          while user_choice < 1 || user_choice > 5
            puts
            puts
            puts "==================================================="
            puts "|       Please enter a valid menu choice.         |"
            puts "==================================================="
            puts "|  Choose Rock, Paper, Scissors, Lizard, Spock.   |"
            puts "|                                                 |"
            puts "|  1)  Rock                                       |"
            puts "|  2)  Paper                                      |"
            puts "|  3)  Scissors                                   |"
            puts "|  4)  Lizard                                     |"
            puts "|  5)  Spock                                      |"
            puts "|                                                 |"
            puts "==================================================="
            print "   Enter menu choice: "
            user_choice = gets.to_i
          end
        end

        case
          when computer_choice == 0 && user_choice == 1
            userTie
          when computer_choice == 0 && user_choice == 2
            userWin
          when computer_choice == 0 && user_choice == 3
            userLost
          when computer_choice == 0 && user_choice == 4
            userLost
          when computer_choice == 0 && user_choice == 5
            userWin
          when computer_choice == 1 && user_choice == 1
            userLost
          when computer_choice == 1 && user_choice == 2
            userTie
          when computer_choice == 1 && user_choice == 3
            userWin
          when computer_choice == 1 && user_choice == 4
            userWin
          when computer_choice == 1 && user_choice == 5
            userLost
          when computer_choice == 2 && user_choice == 1
            userWin
          when computer_choice == 2 && user_choice == 2
            userLost
          when computer_choice == 2 && user_choice == 3
            userTie
          when computer_choice == 2 && user_choice == 4
            userLost
          when computer_choice == 2 && user_choice == 5
            userWin
          when computer_choice == 3 && user_choice == 1
            userWin
          when computer_choice == 3 && user_choice == 2
            userLost
          when computer_choice == 3 && user_choice == 3
            userWin
          when computer_choice == 3 && user_choice == 4
            userTie
          when computer_choice == 3 && user_choice == 5
            userLost
          when computer_choice == 4 && user_choice == 1
            userLost
          when computer_choice == 4 && user_choice == 2
            userWin
          when computer_choice == 4 && user_choice == 3
            userLost
          when computer_choice == 4 && user_choice == 4
            userWin
          when computer_choice == 4 && user_choice == 5
            userTie
        end

        puts
        puts
        puts "==================================================="
        puts "|                  Game Result                    |"
        puts "==================================================="
        puts "   The computer chose #{rpsls[computer_choice]}"
        puts "   You chose #{rpsls[user_choice - 1]}"
        puts
        puts "   You #{$outcome}"
        puts
        puts "---------------------------------------------------"
        puts "|                Your Statistics                  |"
        puts "---------------------------------------------------"
        puts "   Wins   - #{$win}"
        puts "   Losses - #{$loss}"
        puts "   Ties   - #{$tie}"
        puts
        puts "   Total Games - #{$games}"
        puts "==================================================="
        print "   Press Enter key to continue... "
        pause = gets

        playAgain
        menu_choice = gets.to_i

        if menu_choice < 1 || menu_choice > 2
          while menu_choice < 1 || menu_choice > 2
            playAgainError
            menu_choice = gets.to_i
          end
        end

        # Exit game
        if menu_choice == 2
          menu_choice = 0
        end
      end
    end

    # Game Rules
    if menu_choice == 3
      puts
      puts
      puts "==================================================="
      puts "|  Select a version to view the rules?            |"
      puts "|                                                 |"
      puts "|  1)  Normal   - Rock, Paper, Scissors           |"
      puts "|                                                 |"
      puts "|  2)  Advanced - Rock, Paper, Scissors,          |"
      puts "|                 Lizard, Spock                   |"
      puts "|                                                 |"
      puts "|  3)  Back to Previous Menu                      |"
      puts "|                                                 |"
      puts "|  4)  Exit                                       |"
      puts "==================================================="
      print "   Enter menu choice: "
      menu_choice = gets.to_i

      while menu_choice < 1 || menu_choice > 4
        puts
        puts
        puts "==================================================="
        puts "|       Please enter a valid menu choice.         |"
        puts "==================================================="
        puts "|  Select a version to view the rules?            |"
        puts "|                                                 |"
        puts "|  1)  Normal   - Rock, Paper, Scissors           |"
        puts "|                                                 |"
        puts "|  2)  Advanced - Rock, Paper, Scissors,          |"
        puts "|                 Lizard, Spock                   |"
        puts "|                                                 |"
        puts "|  3)  Back to Previous Menu                      |"
        puts "==================================================="
        print "   Enter menu choice: "
        menu_choice = gets.to_i
      end

      if menu_choice == 1
        puts
        puts
        puts "==================================================="
        puts "|  Rules for Normal Gameplay.                     |"
        puts "|                                                 |"
        puts "|  Rock crushes Scissors                          |"
        puts "|  Paper covers Rock                              |"
        puts "|  Scissors cut Paper                             |"
        puts "|                                                 |"
        puts "|  The computer will randomly pick Rock, Paper,   |"
        puts "|  or Scissors before you pick your choice.       |"
        puts "|                                                 |"
        puts "|  When prompted, choose your selection and       |"
        puts "|  try to beat the computer. Your stats will      |"
        puts "|  appear below the game results.                 |"
        puts "==================================================="
        print "   Press Enter to continue..."
        pause = gets

        menu_choice = 0
      end

      if menu_choice == 2
        puts
        puts
        puts "==================================================="
        puts "|  Rules for Advanced Gameplay.                   |"
        puts "|                                                 |"
        puts "|  Scissors cut Paper                             |"
        puts "|  Paper covers Rock                              |"
        puts "|  Rock crushes Lizard                            |"
        puts "|  Lizard poisons Spock                           |"
        puts "|  Spock smashes Scissors                         |"
        puts "|  Scissors decapitate Lizard                     |"
        puts "|  Lizard eats Paper                              |"
        puts "|  Paper disproves Spock                          |"
        puts "|  Spock vaporizes Rock                           |"
        puts "|  Rock crushes Scissors                          |"
        puts "|                                                 |"
        puts "|  The computer will randomly pick Rock, Paper,   |"
        puts "|  Scissors, Lizard, or Spock before you pick     |"
        puts "|  your choice.                                   |"
        puts "|                                                 |"
        puts "|  When prompted, choose your selection and       |"
        puts "|  try to beat the computer. Your stats will      |"
        puts "|  appear below the game results.                 |"
        puts "==================================================="
        print "   Press Enter to continue..."
        pause = gets

        menu_choice = 0
      end

      if menu_choice == 3
        menu_choice = 0
      end
    end

    # Exit game
    if menu_choice == 4
      exitGame
    end
  end
end

  # Exit game
if menu_choice == 2
  exitGame
end