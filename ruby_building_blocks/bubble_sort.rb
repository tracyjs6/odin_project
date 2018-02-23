def bubble_sort(nums, ctr)

  for i in 0...nums.length - ctr do
    if nums[i] > nums[i + 1]
      nums[i], nums[i + 1] = nums[i + 1], nums[i]
    end
    p nums
  end

  if ctr == (nums.length - 1)
    return nums
  else
    ctr += 1
    bubble_sort(nums, ctr)
  end

end


arr1 = [6, 5, 3, 8, 7, 4, 2, 1]
iter = 1
bubble_sort(arr1, iter)