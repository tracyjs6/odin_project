# add in private methods!!!
# try to get rid of all the instance vars by adding attr_XXX


require "./players"
require "./board"

class Game
  include Players
  include Board

  attr_reader :players

  def initialize
    create_players
    puts "\nCreated 2 players: "
    puts "   #{players[0].name} will go first as #{players[0].symbol}'s"
    puts "   #{players[1].name} will follow as #{players[1].symbol}'s"

    @game_board = Board.new

    ctr = 0
    while true
      @game_board.current_player(ctr, players[ctr % 2].name, players[ctr % 2].symbol)
      @game_board.make_move
      ctr += 1
    end

  end  

end


Game.new



