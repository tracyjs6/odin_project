# Build a method #merge_sort that takes in an array and returns a sorted array, using a recursive merge sort methodology.

# After more reading (wikipedia) I realized my initial implementation could be much simplified, and here is the result! 
# My initial branching logic was good but the usage of array of arrays was way off the mark, as I was starting to suspect

 
def merge_sort(ary)
  return ary if ary.length < 2  
  new_ary = []
  
  left = ary[0..(ary.length/2-1)]
  right = ary[(ary.length/2)..-1]
  
  left = merge_sort(left)
  right = merge_sort(right)
  
  while (!left.empty?) || (!right.empty?)
    if left.empty?
      new_ary.push right.shift
    elsif right.empty?
      new_ary.push left.shift
    else
      left[0] < right[0] ? (new_ary.push left.shift) : new_ary.push(right.shift)
    end
  end
  new_ary

end

merge_sort([2])
merge_sort([2, 1])
merge_sort([2, 1, 5])
merge_sort([2, 1, 5, 0])
merge_sort([2, 1, 5, 0, 9])
merge_sort([2, 1, 5, 0, 9, 8])
merge_sort([2, 1, 5, 0, 9, 5])
merge_sort([2, 1, 5, 4, 9, 8, 0])
merge_sort([2, 1, 5, 4, 9, 6, 7, 3, 8, 6])






