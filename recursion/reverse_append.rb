def reverse_append(ary, n)
  return ary if n < 0                   # => true, false, true, false, false, true, false, false, false, true
  reverse_append((ary.unshift n), n-1)  # => [0], [0, 1], [0, 1], [0, 1, 2], [0, 1, 2], [0, 1, 2]
end                                     # => :reverse_append

reverse_append([], -1)  # => []
reverse_append([], 0)   # => [0]
reverse_append([], 1)   # => [0, 1]
reverse_append([], 2)   # => [0, 1, 2]

# Yikes, the one below works but I'm not entirely sure why??? It's late, I'll figure in the morning
# Here is a good explanation from stack overflow
# append() says "If I haven't gotten to a negative value, concatenate my n to the array, and then get the array that results from concatenating all smaller values of n and return it", while reverse_append() says "If I haven't gotten to a negative value, get the array that results from concatenating all smaller values of n, and then concatenate my n to the result and return it." 
# And another
#    ...
#    The method reverse_append([],2) is called.
#    Since 2 >= 0, the return statement does not get called.
#    The method reverse_append([],1) is called.
#    Since 1 >= 0, the return statement does not get called.
#    The method reverse_append([],0) is called.
#    Since 0 >= 0, the return statement does not get called.
#    The method reverse_append([],-1) is called.
#    Since -1 < 0, the array ([]) is returned.
#    We pop up one level in our call stack, to where n = 0 and arr = [].
#    arr << n and arr is returned, so now arr = [0].
#    We pop up one level in our call stack, to where n = 1 and arr = [0].
#    arr << n and arr is returned, so now arr = [0, 1].
#    We pop up one level in our call stack, to where n = 2 and arr = [0, 1].
#    arr << n and arr is returned, so now arr = [0, 1, 2].
#    ...
#    Finally, the "top-level" method returns, and we have our final result.

def reverse_append2(ary, n)
  return ary if n < 0            # => false, true, false, false, true, false, false, false, true, true
  reverse_append2(ary, (n - 1))  # => [],  [],  [0],    [],  [0],    [0, 1]
  ary.push n                     # => [0], [0], [0, 1], [0], [0, 1], [0, 1, 2]
end                              # => :reverse_append2
  
reverse_append2([], -1)  # => []          
reverse_append2([], 0)   # => [0]
reverse_append2([], 1)   # => [0, 1]
reverse_append2([], 2)   # => [0, 1, 2]


