# Write a method #fibs which takes a number and returns that many members of the fibonacci sequence. Use iteration for this solution.
# Now write another method #fibs_rec which solves the same problem recursively.  

def fibs(n, fib_seq = [1, 1])
  return [1] if n == 1
  for i in 2...n
    fib_seq.push (fib_seq[i - 2] + fib_seq[i - 1])
  end
  fib_seq 
end

p fibs(10)

def fibs_rec(n, fib_seq = [1, 1])
  return [1] if n == 1
  while fib_seq.length < n
    fib_seq.push (fib_seq[-2] + fib_seq[-1])
    fibs_rec(n, fib_seq)
  end
  fib_seq
end

fibs_rec(10)

# or could shove the push into the recursive call, which then allows for a ternary conditional, ... but seems much harder to read that way
def fibs_rec(n, fib_seq = [1, 1])
  return [1] if n == 1
  (fib_seq.length < n) ? (fibs_rec(n, (fib_seq.push (fib_seq[-2] + fib_seq[-1])))) : fib_seq
end