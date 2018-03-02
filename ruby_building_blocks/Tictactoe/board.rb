module Board

  class Board
    attr_reader :board, :ctr, :player_name, :player_symbol, :move

    def initialize
      make_board
      puts "\nBelow is the board that you will be playing on"
      puts "Moves will be column then row, eg b2\n\n"
      show_board
    end

    def check_move(ctr, player_name, player_symbol, move)
      #  this is a bit messy, but don't know how to get all the data into this classes instances without???
      @ctr = ctr
      @player_name = player_name
      @player_symbol = player_symbol
      @move = move
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
      puts "#{@board[0..2]}\n#{@board[3..5]}\n#{@board[6..8]}"
    end

    def update_board
      (board[move-1] = player_symbol) 
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
          puts "#{player_name} wins."
          exit
        end
        if ctr == 8
          puts "We have a draw."
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
        return true if i.all? { |position| board[position] == player_symbol}
      end
      false
    end

  end

end
