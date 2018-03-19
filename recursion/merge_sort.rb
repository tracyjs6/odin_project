# Build a method #merge_sort that takes in an array and returns a sorted array, using a recursive merge sort methodology.

# def merge_sort(ary, new_ary = [], ctr = 2)
#   n = ary.length
#   ary if n < 2# 
#   for i in 0...n/ctr
#     (ary[2 * i] < ary[2 * i + 1]) ? new_ary.push([ary[2 * i], ary[2 * i + 1]]) : new_ary.push([ary[2 * i + 1], ary[2 * i]])
#   end
#   new_ary.push([ary[-1]]) if n % 2 != 0
#   p ary
#   p new_ary
# end

# The below works but I get the feeling I should not be using arrays to hold the 
 
def merge_sort(ary, type = "split", ctr = 0)
  new_ary = []
  return ary if ary.length < 2  

    # the below will only work with arrays that start out flat, would need another method if want to merge sort an array of arrays
    # also maybe can do the split much faster with my code above? 
    # Need to look into it & why all discussions don't just start with simply ordering pairs to start?
    # Seems like it would be much quicker, but guess I would need to take perf stats to know for sure.
    case type
    when "split"
      # the only reason I need ctr is for this specific scenario, what else could I do
      if ctr == 0
        new_ary.push ary[0..ary.length/2 - 1], ary[ary.length/2..-1]
      else
        for i in 0..(ary.length - 1)
          if ary[i].length < 2 
            new_ary.push ary[i]
          else
            new_ary.push ary[i][0..ary[i].length/2 - 1], ary[i][ary[i].length/2..-1]
          end
        end
      end
        ctr += 1
        if (new_ary.length != ary.flatten.length) 
          merge_sort(new_ary, "split", ctr) 
        else
          merge_sort(new_ary, "merge", ctr = 0)
        end

    when "merge"
      new_ary = []
      # want to get rid of the passed ctr and just leave the ternary conditional
      if ctr == 0
        (ary.length % 2 == 0) ? (ctr = ary.length/2) : (ctr = ary.length/2 + 1)
      end

      for i in 0...ctr
        l = ary[i * 2]        # left ary to merge
        r = ary[(i * 2) + 1]  # right ary to merge
        new_ary.push []

        # below is for when there is no right element
        if r.nil?
          new_ary[i].push l.shift while !l.empty?
          puts "HERE4: new_ary: #{new_ary}"
        else
          # else until both left and right elements are empty
          while (!l.empty?) || (!r.empty?)
            if l.length == 0
              new_ary[i].push r.shift
              puts "HERE: new_ary: #{new_ary}"
            elsif r.length == 0
              new_ary[i].push l.shift
              puts "ctr: #{ctr}"
              puts "HERE2: new_ary: #{new_ary}"
            else
              l[0] < r[0] ? (new_ary[i].push l.shift) : new_ary[i].push(r.shift)
              puts "HERE3: new_ary: #{new_ary}"
            end
          end
        end
      end
      sleep 3
      ctr -= 1
      # flattening takes time ... instead if length = 2 should just write to a flattened array
      # or maybe I should do the whole thing in a flattened array
      # wonder what the different performance would be?
      # also if flattened 
      ctr != 0 ? merge_sort(new_ary, "merge", ctr = 0) : (return new_ary.flatten!)

    end
end

merge_sort([2])
merge_sort([2, 1])
merge_sort([2, 1, 5])
merge_sort([2, 1, 5, 0])
merge_sort([2, 1, 5, 0, 9])
merge_sort([2, 1, 5, 0, 9, 8])
merge_sort([2, 1, 5, 0, 9, 5])
# merge_sort([[2], [1], [5], [4], [9]], "merge", 0)
# merge_sort([[1, 2], [4, 5], [9]], "merge", 0)
merge_sort([2, 1, 5, 4, 9, 8, 0])
# merge_sort([[1, 2], [4, 5], [8, 9], [0]], "merge", 0)
# merge_sort([[1, 2, 4, 5], [0, 8, 9]], "merge", 0)
merge_sort([2, 1, 5, 4, 9, 6, 7, 3, 8])
#merge_sort([[1,2, 3], [3,4, 4], [5,6,7, 5]])





