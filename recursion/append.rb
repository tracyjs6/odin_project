def append(ary, n)
  return ary if n < 0
  append((ary.push n), (n-1))
end

# append([], 0) # => [0]          append([]].push 0, -1)
# append([], 1) # => [1, 0]       append(([].push 1), 0)
# append([], 2) # => [2, 1, 0]    append(([].push 2), 1)
# append([], 3) # => [3, 2, 1, 0] append(([].push 3), 2)
# append([], -1) # => []          
append([], 12)