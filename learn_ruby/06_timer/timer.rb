class Timer
	attr_accessor :seconds
	attr_writer :num
	
	def initialize(seconds = 0)
		@seconds = seconds
	end

	def time_string
		padded(@seconds / 3600)				# hours
		time = @num + ":"
		padded((@seconds % 3600) / 60)		# mins
		time += @num + ":"
		padded((@seconds % 3600)  % 60)		# remaining seconds
		time += @num
	end

	def padded(num) 
		if num < 10
			@num = "0" + num.to_s
		else
			@num = num.to_s
		end
	end
end

timer = Timer.new
timer.seconds = 6397
puts timer.time_string
# puts timer.padded(11)


