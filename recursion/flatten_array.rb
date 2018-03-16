# Define a recursive function that flattens an array. 
# The method should convert [[1, 2], [3, 4]] to [1, 2, 3, 4] and [[1, [8, 9]], [3, 4]] to [1, 8, 9, 3, 4].

def flatten_array(ary, new_ary)
  
  ary.each do |a| 
    if a.is_a? Array 
      flatten_array(a, new_ary)
    else
      new_ary.push a
    end  
  end
  new_ary
end

p flatten_array([[1, [8, 9]], [3, 4], {a: "a", b: "b"}], [])