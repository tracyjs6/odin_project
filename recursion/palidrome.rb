# Define a recursive function that returns true if a string is a palindrome and false otherwise.

def palidrome(arg)
  if arg.length <= 1
    true
  elsif arg[0] != arg[-1]
    false
  else 
    palidrome(arg[1..-2])
  end
end

puts palidrome("aacbcaa")
puts palidrome("aacbbaa")


