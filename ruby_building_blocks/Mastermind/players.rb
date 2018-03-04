module Players

  # Not sure on naming conventions when a param has multi-uses, not loving :symbol_or_role!!!
  # Maybe should be something like player_attributes? Maybe there is a way to say either this or that?
  Players = Struct.new(:name, :symbol_or_role)

  def create_players(game)
    @names = []
    puts ""
    for i in 0..1
      print "   Please enter player #{i+1} name: "
      @names << gets.chomp
    end

    case game
    when "TicTacToe"
      assign_initial_symbol_or_role("symbols")
    when "MasterMind"
      assign_initial_symbol_or_role("roles")
    end

    @players = @names.map do |name, role|
      Players.new(name, role)
    end

    @players
  end

  private

  def assign_initial_symbol_or_role(attribute)
    case attribute
    when "symbols"
      options = ["X", "O"]
    when "roles" 
      options = ["codemaker", "codebreaker"]
    end

    @names = @names.zip(options.shuffle)
    # Setting it so the first player has the first option because "X" always goes first, as does "codemaker"
    @names.rotate! if @names[0][1] == options[1]
    puts "\nAfter a random selection ..."
    puts "   #{@names[0][0]} will be the #{@names[0][1]}"
    puts "      and\n   #{@names[1][0]} will be the #{@names[1][1]}"
  end

  def role_switch
    @players[0].current_role, @players[1].current_role = @players[1].current_role, @players[0].current_role
  end

end