# Can't choose a spot already taken
# Need to put in errors

class TicTacToe

  def initialize(player1, player2)
    Players.new(player1, player2)
    @player1 = [player1, "X"]
    @player2 = [player2, "O"]
    @curr_player = @player1
    @line1 = [[" "], [" "], [" "]]
    @line2 = [[" "], [" "], [" "]]
    @line3 = [[" "], [" "], [" "]]
    @ctr = 0
    self.show_board
    self.make_move
  end

  def show_board
    p "    a     b     c"
    puts "1. #{@line1[0]} #{@line1[1]} #{@line1[2]}"
    puts "2. #{@line2[0]} #{@line2[1]} #{@line2[2]}"
    puts "3. #{@line3[0]} #{@line3[1]} #{@line3[2]}"
  end

  def make_move
    puts "#{@curr_player[0]}, please make your move, eg b2"
    @move = gets.chomp
    self.store_move
  end

  def store_move
    coords = @move.split("")

    x_coords = {"a" => 0, "b" => 1, "c" => 2}
    x = x_coords[coords[0]]
    if x.nil?
      puts "You did not enter valid coordinates, please try again"
      self.make_move
    end

    y_coords = {"1" => @line1, "2" => @line2, "3" => @line3}
    y = y_coords[coords[1]]
    if y.nil?
      puts "You did not enter valid coordinates, please try again"
      self.make_move
    end

    if (y[x][0] == " ") 
      (y[x][0] = @curr_player[1]) 
    else
      puts "That spot is already taken"
      self.make_move
    end
    @ctr += 1
    self.show_board
    self.check_if_won
  end

  def change_player
    (@curr_player == @player1) ? (@curr_player = @player2) : (@curr_player = @player1)
    self.make_move
  end

  def check_if_won
    if @ctr >= 5
      # DO STUFF TO SEE IF WON, and if not carry on
      if @ctr == 9
        puts "We have a draw"
        exit
      else
        self.change_player
      end
    else
      self.change_player
    end
  end

end

class Players

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
  end

end


game = TicTacToe.new("player1", "player2")




