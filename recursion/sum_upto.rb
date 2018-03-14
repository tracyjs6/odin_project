def sum_upto(n)
  return 0 if n == 0
  sum_upto(n-1) + n
end

# sum_upto(0) # => 0
# sum_upto(1) # => 1 (sum_upto(0) + 1)
# sum_upto(2) # => 3 (sum_upto(1) + 2)
# sum_upto(3) # => 6 (sum_upto(2) + 3)
sum_upto(12)
