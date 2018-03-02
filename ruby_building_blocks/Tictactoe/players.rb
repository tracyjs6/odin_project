module Players

#  class Players
#    attr_reader :player, :symbol
#    def initialize(player, symbol)
#      @player = player
#      @symbol = symbol
#    end
#  end
  Players = Struct.new(:name, :symbol)

  def create_players
      @names = []
      for i in 0..1
        puts "Please enter player #{i+1}'s name:"
        name = gets.chomp
        @names << [name]
      end
      assign_players_symbol
      @players = @names.map do |player, symbol| 
        Players.new(player, symbol)
      end
      @players
  end

  private
  def assign_players_symbol
    symbols = ["X", "O"]
    for i in 0..1
      @names[i][1] = symbols[i]
    end
  end

end
