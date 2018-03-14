module Hangman

  class Dictionary
    attr_reader :word_length

    def initialize(word_length)
      @word_length = word_length
    end

    def select_word
      Dir.chdir("../data")
      f = File.open("5desk.txt")
      line = (rand(f.readlines.length))
      f.rewind      

      # what if we reach beginning of file? Need to do something
      while line > 0
        word = f.gets[0..-3]
        line = line - 1
      end     

      while word.length != word_length
        word = f.gets[0..-3]
      end
      word = word.downcase.split("")
    end

  end

end