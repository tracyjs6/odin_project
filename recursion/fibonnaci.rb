# Define a recursive function that takes an argument n and returns the fibonacci value of that position. 
# The fibonacci sequence is 1, 1, 2, 3, 5, 8, 13, 21... So fib(5) should return 5 and fib(6) should return 8.

# non-recursive
# def fibonnaci(n)
#   return 1 if n <= 2
#   pos1 = 1
#   pos2 = 1
#   for i in 1..(n-2)
#     next_pos = pos1 + pos2
#     pos1, pos2 = pos2, next_pos
#   end
#   next_pos
# end

# puts fibonnaci(5)

# fib(0) # => 0
# fib(1) # => 1
# fib(2) # => 1 (fib(0) + fib(1) => fib(n-2) + fib(n-1))
# fib(3) # => 2 (fib(1) + fib(2) => fib(n-2) + fib(n-1))
# fib(4) # => 3 (fib(2) + fib(3) => fib(n-2) + fib(n-1))
# fib(5) # => 5 (fib(3) + fib(4) => fib(n-2) + fib(n-1))

def fib_recursive(n)
  if n == 0
    0
  elsif n == 1
    1
  else
    fib_recursive(n-2) + fib_recursive(n-1)
  end
end

puts fib_recursive(8)


