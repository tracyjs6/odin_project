module Board

  class Board
    # seem to be an awful lot of getters!!! 3 of which due to my dumb 3 lines of array!
    attr_reader :ctr, :line1, :line2, :line3, :player_name, :player_symbol, :move

    def initialize
      make_board
      puts "\nBelow is the board that you will be playing on"
      puts "Moves will be column then row, eg b2\n\n"
      show_board
    end

    def make_board
      # I am sure I can improve this!!! Should probably be a single array just displayed on separate lines!!! NOT DRY!!!
      @line1 = [[" "], [" "], [" "]]
      @line2 = [[" "], [" "], [" "]]
      @line3 = [[" "], [" "], [" "]]
    end

    def show_board
      p "    a     b     c"
      # Again may be much improved if single array!!!
      puts "1. #{line1[0]} #{line1[1]} #{line1[2]}"
      puts "2. #{line2[0]} #{line2[1]} #{line2[2]}"
      puts "3. #{line3[0]} #{line3[1]} #{line3[2]}"
    end

    def current_player(*args)
      # Intensly dislike having ctr as arg of current_player!!!
      @ctr = args[0]
      @player_name = args[1]
      @player_symbol = args[2]
    end

    def make_move
      puts "\n#{player_name}, please make your move"
      @move = gets.chomp
      check_move
    end 

    def check_move
      # should we be calling so many other methods from a single method?
      coords = move.split("") 
      x_coords = {"a" => 0, "b" => 1, "c" => 2}
      y_coords = {"1" => line1, "2" => line2, "3" => line3}
      if (invalid_coord?(x_coords[coords[0]])) || (invalid_coord?(y_coords[coords[1]]))
        make_move
      elsif space_taken?(y_coords[coords[1]][x_coords[coords[0]]])
        make_move
      else
        show_board
        check_if_won
      end
    end

    def invalid_coord?(coord)
      if coord.nil?
        puts "You did not enter valid coordinates, please try again"
        true
      end
    end

    def space_taken?(coords)
      if (coords[0] == " ") 
        (coords[0] = player_symbol) 
        false
      else
        puts "Those coordinates are already taken"
        true
      end
    end

    def winning_board?
      # Yikes, again due to my stoopid 3 lines or array
      #horizontals = [line1[0..2], line2.[0..2], line3.[0..2]]
      #verticals = [[line1[0], line2[0], line3[0]], [line1[1], line2[1], line3[1]], [line1[2], line2[2], line3[2]]]
      #diagonals = [[line1[0], line2[1], line3[2]], [line1[2], line2[1], line3[0]]]
      # This is a nightmare!!!
    end

    def check_if_won
      if ctr >= 4
        # DO STUFF TO SEE IF WON, and if not carry on
        if ctr == 8
          puts "We have a draw"
          exit
        end
      end
    end

  end

end




