# MasterMind:
# create players
#   specify number of games
#   specify number of rows
#   specify if blanks allowed
# create board
# codemaker chose pattern - 4 color coded pegs: red, orange, yellow, brown, dups allowed, optional blank if chosen
# => the codemaker will be played by the code randomly selecting ... 
# codebreaker makes first guess
# codemaker gives feedback
# => check if any match color & position => black pegs
# => check remaining for color match => white pegs
# and around we go until either 
# correct guess OR end of board
# => show win loss stats
# switch positions and start again, up to no. of games
# => win or draw

require "./players"
require "./board"

class Game
  include Players
  include Board

  attr_reader :game, :game_board, :players, :rows
  attr_accessor :ctr

  def initialize
    game_choice
    create_players(game)
    # Yet do do anything with the number of games option, so removing for now
    # number_of_games

    case game
    when "TicTacToe" 
      @game_board = TicTacToeBoard.new(players)
      # get rid of counter? Use another method of determining which spots have been taken and how many spots remaining in TicTacToe
      # just reminded of more code, where I use counter in current_player, maybe leave after all???
      @ctr = 0
      while true
        game_board.make_move(ctr)
        game_board.check_move
        # why do I have issues with the below, even though ctr used in above method, and have attr_accessor???
        # ctr += 1
        @ctr += 1
      end      
    when "MasterMind" 
      number_of_rows
      @game_board = MasterMindBoard.new(players, rows)
      game_board.make_code
      # could add option for codemaker actually setting code while breaker looks away
      # then store and clear board. For now just automated.
      @ctr = 0
      while (@ctr/4) < rows
        game_board.break_code
        # update_player_board should probably be called directly from break_code and made private
        game_board.update_player_board(ctr)
        # winner?
        @ctr += 4
      end
    end

  end 

  def game_choice
    games = {1 => "TicTacToe", 2 => "MasterMind"}

    while true
      puts "\nWhich 2 player game would you like to play?"
      puts ""
      for i in games
        puts "   #{i[0]}. #{i[1]}"
      end
      print "\n   Enter the number of your choice: "
      begin
        choice = Integer(gets.chomp)
      rescue
        puts "\n   That is not a valid choice, please choose again ..."
      else
        if games.keys.include? choice
          puts "\nYou selected #{games[choice]}"
          @game = games[choice]
          return @game
        else
          # Don't like the fact I've written same thing twice ... Not sure what to do about it at the moment.
          puts "\n   That is not a valid choice, please choose again ..."
        end
      end
    end

  end

#  def number_of_games
#    print "\n\nHow many games would you like to play? It must be an even number: "
#    while true
#      begin
#        @num_games = Integer(gets.chomp)
#      rescue
#        # Again with the repetition, :-(. Should save this text, maybe in Error Module so can re-use
#        print "\n   That is not a valid entry, please try again. How many games?: "
#      else 
#        if (@num_games <= 0) || (@num_games % 2 != 0)
#          print "\n   That is not a valid entry, please try again. How many games?: "
#        else
#          return @num_games
#        end
#      end
#    end
#  end

  def number_of_rows
    row_options = {1 => 12, 2 => 10, 3 => 8}
    # 2nd time used almost the exact same construct, also in game_choice - refactor!!!
    while true
      puts "\nHow many rows would you like the board to have?"
      for i in row_options
        puts "   #{i[0]}. #{i[1]} rows"
      end
      print "\n   Enter the number of your choice: "
      begin
        choice = Integer(gets.chomp)
      rescue
        puts "\n   That is not a valid choice, please choose again ..."
      else
        if row_options.keys.include? choice
          puts "\nYou selected an #{row_options[choice]} row board."
          return @rows = row_options[choice]
        else
          # Don't like the fact I've written same thing twice ... Not sure what to do about it at the moment.
          puts "\n   That is not a valid choice, please choose again ..."
        end
      end
    end
  end

end

Game.new