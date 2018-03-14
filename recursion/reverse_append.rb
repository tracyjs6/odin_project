def reverse_append(ary, n)
  return ary if n < 0
  reverse_append((ary.unshift n), n-1)
end

reverse_append([], -1) # => []
reverse_append([], 0) # => [0]
reverse_append([], 1) # => [0, 1]
reverse_append([], 2) # => [0, 1, 2]

# Yikes, this one works but I'm not entirely sure why??? It's late, I'll figure in the morning
def reverse_append2(ary, n)
  return ary if n < 0
  reverse_append2(ary, (n - 1))
  ary.push n
end
            
reverse_append2([], 0) # => [0]             
reverse_append2([], 1) # => [0, 1]          
reverse_append2([], 2) # => [0, 1, 2]       
reverse_append2([], -1) # => [] 
