module Hangman

  class Game
    attr_accessor :game_state

    def determine_current_game_state
      if (game_state[:counter]-1) == game_state[:max_attempts]
        game_state[:word].each {|l| game_state[:guess].push "-"}
        save_game_state
      elsif game_state[:counter] == 0
        puts "\n\n   Sorry, you have lost."
        puts "   The word was #{game_state[:word].join("").upcase}."
        puts "\n   Better luck next time"
        puts ""
        exit
      else
        make_guess
      end
    end

    def make_guess
      print "\n   Please enter your letter: "
      # need to check entry is a single letter, else request again ...
      choice = gets.chomp.downcase
      game_state[:letters] << (choice + " ")
      game_state[:word].each_with_index do |letter, index|
        game_state[:guess][index] = letter if choice == letter
      end
      save_game_state
    end

    protected
    def show_board
      puts "\n\n#{game_state[:guess]}, letters already chosen '#{game_state[:letters]}'"
      puts "   You have #{game_state[:counter]} attempts left"
      if won?
        puts "\n\n   #{game_state[:name]} you are a winner!!!"
        puts "   The word was #{game_state[:word].join("").upcase}."
        puts ""
        exit
      else
        determine_current_game_state
      end
    end

    private
    def save_game_state
      game_state[:counter] -= 1
      File.open("current_game.yaml", "w+") {|g| g.puts game_state.to_yaml}
      show_board
    end

    def won?
      game_state[:guess].all? {|l| l != "-"}
    end

  end

  class NewGame < Game

    def initialize(player, max, ctr, word)
      @game_state = {name: player.name, max_attempts: max, counter: ctr, word: word, guess: [], letters: ""}
      determine_current_game_state
    end

  end

  class RestartGame < Game

    def initialize
      Dir.chdir("../data")
      @game_state = YAML.load_file('current_game.yaml')
      show_board
    end

  end

end