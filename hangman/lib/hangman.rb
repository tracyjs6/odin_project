# ask player for name
# ask if want to play from a saved game or start new
#   if from saved game, check to see if there is a saved game and continue with guesses
#   if no existing game, or choice is new game
#     select random word from dictionary
#     save word
#     set counter to 0
#     save current_guess_state
#       if counter is 0
#         save dashes and counter to guess file
#         then show board and request guess
#           check guess against original word
#           update array to include any matches
#           check if array still has dashes
#             if no more dashes, guesser wins, exit
#             if dashes still exist
#               update counter
#               save new array and counter
#       if counter > 0 & < 9
#         then show board and request guess
#           check guess against original word
#           update array to include any matches
#           check if array still has dashes
#             if no more dashes, guesser wins, exit
#             if dashes still exist
#               update counter
#               save new array and counter
#     if counter = 9, guesser loses
# 
# ABOVE is my beginning pseudo-code, has changed much since :-)

# Currently no nice way to exit running game!!!, ctr-C works, but should have a better way.
# when restarting game asks for name again but doesn't check it is the same person!!!
# could be a sport and say if already chosen a letter
# Could add functionality to know number of distinct letters left to guess vs guesses left, to complete game earlier for losses
# should check counter not 0 when restarting game, if zero then start new game instead
# Figure out how to save error (and maybe other) text messages to a seperate file
# Figure how to not repeat myself in error situations with the rescue for exception, then the 2nd check for other invalidness - how to combine???
# Also update to save to a database, and save a bunch of games to pick from - move completed games to another table
# Write tests - not learnt how to do that yet :-(
# When trying to update I'll see exactly how difficult/easy to read the code without comments!!!

require_relative "hangman/player"
require_relative "hangman/dictionary"
require_relative "hangman/game"
require "yaml"

class HangMan
  include Hangman

  attr_reader :player

  def get_player_name
    print "Please enter your name: "
    name = gets.chomp
    @player = Player.new(name.capitalize)
    puts "\n   Hello #{@player.name}. Good Luck!"
  end

  def start_game
    option = new_or_existing_game
    if option == 1
      word_length = length_of_word_to_guess
      guesses = number_of_guesses
      dictionary = Dictionary.new(word_length)
      word = dictionary.select_word
      game = NewGame.new(player, guesses, (guesses+1), word)
    else
      game = RestartGame.new
    end
  end

  def new_or_existing_game
    puts "\n#{player.name} would you like to play a new game or finish one you already started?"
    option = 0
    while true
      options = {1 => "new game", 2 => "existing game"}
      begin
        puts "   #{options.keys[0]}. #{options.values[0]}"
        puts "   #{options.keys[1]}. #{options.values[1]}"
        print "\n   Select your option, (1 or 2): "
        option = Integer(gets.chomp)
      rescue
        puts "That was not a valid choice, please select either option 1 or 2"
      end
      if !(option == 1 || option == 2)
        puts "That was not a valid choice, please select either option 1 or 2"
      else
        puts "\nYou chose #{options.values[option-1]}"
        return option
      end
    end
  end

  def length_of_word_to_guess
    print "\n#{player.name}, how long would you like the word to be, please choose a number between 5 and 12?: "
    length = 0
    while true
      begin
        length = Integer(gets.chomp)
      rescue
        puts "That was not a valid choice, please choose number between 5 and 12"
      end
      if !length.between?(5, 12)
        puts "That was not a valid choice, please choose number between 5 and 12"
      else
        puts "\nYou chose to guess a word of #{length} characters"
        return length
      end
    end
  end

  def number_of_guesses
    print "\n#{player.name}, how many guesses would you like?, please choose number between 5 and 12: "
    guesses = 0
    while true
      begin
        guesses = Integer(gets.chomp)
      rescue
        puts "That was not a valid choice, please choose number between 5 and 12"
      end
      if !guesses.between?(5, 12)
        puts "That was not a valid choice, please choose number between 5 and 12"
      else
        puts "\nYou chose #{guesses} guesses"
        return guesses
      end
    end
    
  end

end 


# This may be confusing with dups of module and class name, BUT works from here, thou' not from the executable in bin
#hangman = Hangman.new
#hangman.get_player_name
#hangman.start_game