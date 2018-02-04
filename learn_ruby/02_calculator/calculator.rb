# Simple calculator


def add(a, b)
	result = a + b
end

def subtract(a, b)
	result = a - b
end

# def sum(a)
# 	result = 0
# 	a.each { |x| result += x }
# 	result
# end

# BETTER SUM
def sum(a)
  a.reduce(0, :+)
end

# def multiply(*a)
# 	result = 1
# 	a.each { |x| result *= x }
# 	result
# end

# BETTER MULTIPLY
def multiply(*a)
  a.reduce(1, :*)
end

def power(a, b)
	result = a ** b
end

# the factorial of a non-negative integer n, denoted by n!, is the product of all positive integers less than or equal to n

def factorial(a)
	result = 1
	if a == 0
		result = 0
	elsif 1.upto(a) do |x|
	#elsif a.downto(1) do |x|
		result *= x
		# puts "X: #{x}"
		# puts "RESULT: #{result}"
		end
	end
	result
end

