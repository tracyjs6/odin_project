def translate(sentence)

	words = sentence.split

	words.each_with_index do |word, index|
		string_to_move = ""
		word[0] != word[0].downcase ? capitalized = true : capitalized = false
		while true
			if word[0] =~ /[^aeiou]/i
				string_to_move = string_to_move + word[0]
				word = word[1..-1]
			elsif "u".include? word[0]
				if string_to_move[-1] =~ /[Qq]/
					string_to_move = string_to_move + word[0]
					word = word[1..-1]
				end
			else
				word = word + string_to_move + "ay"
				capitalized == true ? words[index] = word.capitalize : words[index] = word
				break
			end
		end
	end
	words.join(" ")
end

# The only thing bothering me about this method now is the duplication of the following
# string_to_move = string_to_move + word[0]
# word = word[1..-1]
# Hmmmm ... what to do about it? Create a new method? Find a way to combine the 2 statements into 1
# just found 1 more thing I might want to improve - use map/collect to change all words at once rather than use each?

# puts translate("I am Tracy")
