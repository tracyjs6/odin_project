# Implement a method #substrings that takes a word as the first argument and then an array of valid substrings 
# your dictionary) as the second argument. 
# It should return a hash listing each substring (case insensitive) that was found in the original string and 
# how many times it was found.

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
# dictionary = ["low", "below", "low"]

def substrings(word, word_list)

	@word_count = {}

	word_list.each do |x|
		next if x.length > word.length
		if x.length <= word.length
			for i in 0..(word.length - x.length) do
				if word[i..(i + x.length - 1)] == x
					@word_count.has_key?(x) ? @word_count[x] += 1 : @word_count[x] = 1
				end
			end

		end
	end
	p @word_count
end

substrings("below", dictionary)