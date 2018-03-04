module Board

  class Board
    attr_reader :ctr, :players

    def initialize(players)
      @players = players
      make_board
      puts "\nBelow is the board that you will be playing on"
      show_board
    end

  end

  class TicTacToeBoard < Board
    attr_reader :board, :move

    def initialize(players)
      super
      puts "Moves will be column then row, eg b2\n\n"
    end

    def make_move(ctr)
      @ctr = ctr
      print "\n   #{players[ctr % 2].name}, please make your move: "
      # Need to validate the input
      @move = Integer(gets.chomp)
    end    

    def check_move
      if invalid_value? || space_taken?
        make_move
      else
        update_board
        show_board
        check_if_won
      end
    end

    private

    def make_board
      @board = (1..9).to_a
    end

    def show_board
      puts ""
      puts "   #{@board[0..2]}\n   #{@board[3..5]}\n   #{@board[6..8]}"
    end

    def update_board
      (board[move-1] = players[ctr % 2].symbol_or_role) 
    end

    def invalid_value?
      if move <= 0 || move > 9
        puts "You did not enter valid coordinates, please try again"
        true
      end
    end

    def space_taken?
      if (1..9) === board[move-1] 
        false
      else
        puts "Those coordinates are already taken"
        true
      end
    end

    def check_if_won
      if ctr >= 4
        if winner?
          puts "\n*************************\n   #{players[ctr % 2].name} wins.\n*************************\n"

          exit
        end
        if ctr == 8
          puts "\n   We have a draw."
          exit
        end
      end
    end

    def winner?
      # horizontals = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
      # verticals = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
      # diagonals = [[0, 4, 8], [2, 4, 6]]
      winning_positions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
      for i in winning_positions
        return true if i.all? { |position| board[position] == players[ctr % 2].symbol_or_role}
      end
      false
    end

  end

  class MasterMindBoard < Board
    attr_reader :rows, :player_board, :feedback_board, :code, :guess
    attr_accessor :ctr

    def initialize(players, rows)
      @rows = rows
      super(players)
      # blanks_allowed? <= NOT YET IMPLEMENTED!!!
    end

    def blanks_allowed?
      puts "Would you like to play with blank spaces allowed? y/n"
      # similar construct to game_choice & number_of_rows, only this time y/n option, rather than hash options
      while true
        begin
          choice = String(gets.chomp)
        rescue
            puts "\n   That is not a valid choice, please choose again ..."
        else
          if choice.downcase == "y"
            return true
          elsif choice.downcase == "n"
            return false
          else
            puts "\n   That is not a valid choice, please choose again ..."
          end
        end
      end
    end

    def make_code
      # leaving as public 'cos want option for codemaker to make the code
      # add if blanks allowed code, hash would have 1 more option "empty" => "E"
      code_choices = %w{R O Y G} # Red, Orange, Yellow, Green
      @code = []
      for i in 0..3
        code[i] = code_choices[rand(i+1)]
      end
      p "\n*** THE CODE IS: #{@code} ***"
    end

    def break_code
      # duplicating the choices with code_choices in make_code above, make them the same object so only create once
      options = {"R" => "(red)", "O" => "(orange)", "Y" => "(yellow)", "G" => "(green)"}
      puts "\nYour options are: "
      options.each_pair {|key, value| puts "   #{key} #{value}"}
      puts "\nEntry should be of the form RRYO"
      print "\n\n   Please enter your guess: "
      # Need to validate below input - length 4, contains only options.keys
      @guess = gets.chomp.upcase.split("")
    end

    def update_player_board(ctr)
      @ctr = ctr
      for i in guess
        player_board[ctr] = i
        ctr += 1
      end
      show_board
      check_for_matches
    end

    private
    def make_board
      no_of_cells = (4 * rows)
      @player_board = Array.new(no_of_cells, " ")
      @feedback_board = Array.new(no_of_cells, " ")
      # Not always players[1] - need to unhardcode, but don't have ctr value yet :-(
      puts "\n... 'The Code' has been set ... #{players[1].name} time for your first attempt to break it!"
    end

    def show_board
      r = 0
      puts  "\n       Guess                  Feedback"
      while r < (rows*4)
        print "#{player_board[r..(r+3)]}    #{feedback_board[r..(r+3)]}\n"
        r += 4
      end
    end

    def check_for_matches
      # Should probably split into exact_match & color_match methods, but want to move on and learn something new!!!
      # Below seems very convoluted, I'm sure there is a better way!!!
      code_dup = code.dup
      matches = []
      # Exact match
      for i in 0...code_dup.length
        if guess[i] == code_dup[i]
          matches.push "B"
          guess[i] = nil
          code_dup[i] = nil
        end
      end
      guess.compact!
      code_dup.compact!
      # Color match
      for i in 0...code_dup.length
        code_dup.any? do |elem| 
          if elem == guess[i]
            matches.push "W"
            elem = nil
          end
        end
      end
      update_feedback_board(matches)
      check_if_won(matches)
    end

    def update_feedback_board(matches)
      for i in matches
        feedback_board[ctr] = i
        # why do I always have issues with ctr??? Have to use @ctr to update, even though attr_accessor
        @ctr += 1
      end
      show_board
    end   

    def check_if_won(matches)
      if winner?(matches)
        puts "\n*************************\n   #{players[(ctr % 2)+1].name} wins.\n*************************\n"
        exit
      end
    end

    def winner?(matches)
      matches.all? {|elem| elem == "B"}
    end 

  end

end


