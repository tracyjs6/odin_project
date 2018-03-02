require "./players"
require "./board"

class Game
  include Players
  include Board

  attr_reader :players, :player_name, :player_symbol, :move
  attr_accessor :ctr

  def initialize
    create_players
    puts "\nCreated 2 players: "
    puts "   #{players[0].name} will go first as #{players[0].symbol}'s"
    puts "   #{players[1].name} will follow as #{players[1].symbol}'s"

    @game_board = Board.new

    @ctr = 0
    while true
      current_player
      make_move
      @game_board.check_move(ctr, player_name, player_symbol, move)
      # why do I have issues with the below, even though ctr used in above method, and have attr_accessor???
      # ctr += 1
      @ctr += 1
    end

  end 

  def make_move
    puts "\n#{player_name}, please make your move"
    @move = gets.chomp.to_i
  end 

  private
  def current_player
    @player_name = players[ctr % 2].name
    @player_symbol = players[ctr % 2].symbol
  end 

end


Game.new



