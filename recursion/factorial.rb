# Define a recursive function that finds the factorial of a number.

# Factorials
# 1 => 1
# 2 => 1 * 2 => 2
# 3 => 1 * 2 * 3 => 6
# 4 => 1 * 2 * 3 * 4 => 24
# 5 => 1 * 2 * 3 * 4 * 5 => 120


def factorial(n)
  return n if n == 1
  factorial(n-1) * n
end

puts factorial(5)
