require_relative "../03_simon_says/simon_says"

class Book

	attr_writer :title

	def title
		titleize(@title)
	end

end

# book = Book.new
# book.title = "the man in the iron mask"
# puts book.title