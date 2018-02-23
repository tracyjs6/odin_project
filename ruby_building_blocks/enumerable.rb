module Enumerable

  # each: works with Array, Hash and Range and returns self
  def my_each
    return self.to_enum(:my_each) unless block_given?
    enum = self.to_a
    for i in 0...(enum.length)
      yield(enum[i])
    end
    self
  end

  # each_with_index: works with Array, Hash and Range and returns self
  def my_each_with_index
    return self.to_enum(:my_each_with_index) unless block_given?
    enum = self.to_a
    for i in 0...(enum.length)
      yield(enum[i], i)
    end
    self
  end

  # select: works with Array, Hash and Range and returns Array of selected values for Array & Range, and Hash for hash
  def my_select
    return self.to_enum(:my_select) unless block_given?
    new_enum = []
    enum = self.to_a
    type = "ary"
    for i in 0...(enum.length)
      if (self.is_a?(Array) || self.is_a?(Range))
        new_enum.push enum[i] if yield(enum[i])
      else
        new_enum.push enum[i] if yield(enum[i][0], enum[i][1])
        type = "hsh"
      end
    end
    type == "ary" ? new_enum : new_enum.to_h
  end

  def my_all?
    enum = self.to_a
    for i in 0...(enum.length)
      if (self.is_a?(Array) || self.is_a?(Range))
        return false if yield(enum[i]) == false
      elsif yield(enum[i][0], enum[i][1]) == false
        return false
      end
    end
    true
  end

    # any?: returns true/false
  def my_any?
    enum = self.to_a
    for i in 0...(enum.length)
      if (self.is_a?(Array) || self.is_a?(Range))
        return true if yield(enum[i]) == true
      elsif yield(enum[i][0], enum[i][1]) == true
        return true
      end
    end
    false
  end

  # none?: returns true/false
  def my_none?
    enum = self.to_a
    for i in 0...(enum.length)
      if (self.is_a?(Array) || self.is_a?(Range))
        return false if yield(enum[i]) == true
      elsif yield(enum[i][0], enum[i][1]) == true
        return false
      end
    end
    true
  end

  # count: returns int, dependent on argument. String, Array, Range and Hash.
  # 1) no arg => number of elements 2) int/string arg => no. of matches 3) block arg => no. of trues
  # String only does comparison with other string, no empty args or block - I have written so does all 3
  def my_count(argy = nil)
    self.is_a?(String) ? enum = self.split("") : enum = self.to_a
    ctr = 0
    if block_given?
      for i in 0...enum.length
        if !(self.is_a?(Hash))
          ctr += 1 if yield(enum[i]) == true
        else
          ctr += 1 if yield(enum[i][0], enum[i][1]) == true
        end
      end
    elsif argy.nil?
      return enum.length
    else
      for i in 0...enum.length
        ctr += 1 if enum[i] == argy
      end
    end
    ctr
  end

  # # map:
  # # takes block
  # #
  # def my_map
  #   return self.to_enum(:my_map) unless block_given?
  #   enum = self.to_a
  #   new_enum = []
  #   for i in 0...(enum.length)
  #     if (self.is_a?(Array) || self.is_a?(Range))
  #       new_enum.push yield(enum[i])
  #     else
  #       new_enum.push yield(enum[i][0], enum[i][1])
  #     end
  #   end
  #   new_enum
  # end
  # #
  # # takes proc
  # #
  # def my_map(proc)
  #   # return self.to_enum(:my_map) unless block_given?
  #   enum = self.to_a
  #   new_enum = []
  #   for i in 0...(enum.length)
  #     if (self.is_a?(Array) || self.is_a?(Range))
  #       new_enum.push proc.call(enum[i])
  #     else
  #       new_enum.push proc.call(enum[i][0], enum[i][1])
  #     end
  #   end
  #   new_enum
  # end
  # #
  # # takes block or proc 1
  # #
  # def my_map(&block)
  #   # return self.to_enum(:my_map) unless block_given?
  #   enum = self.to_a
  #   new_enum = []
  #   for i in 0...(enum.length)
  #     if (self.is_a?(Array) || self.is_a?(Range))
  #       new_enum.push block.call(enum[i])
  #     else
  #       new_enum.push block.call(enum[i][0], enum[i][1])
  #     end
  #   end
  #   new_enum
  # end
  # #
  # # takes block or proc 2
  # #
  def my_map(&block)
    # return self.to_enum(:my_map) unless block_given?
    enum = self.to_a
    new_enum = []
    for i in 0...(enum.length)
      if (self.is_a?(Array) || self.is_a?(Range))
        new_enum.push yield(enum[i])
      else
        new_enum.push yield(enum[i][0], enum[i][1])
      end
    end
    new_enum
  end

  # inject:
  # reduce(initial, sym) → obj 
  # reduce(sym) → obj
  # reduce(initial) { |memo, obj| block } → obj
  # reduce { |memo, obj| block } → obj 
  def my_inject(*args)
    case args.length
      when 0
        # block given, initial == first elem
        total = self[0]
        self[1..-1].my_each {|x| total = yield(total, x)}
      when 1
        # if block, arg == initial
        if block_given?
          total = args[0]
          self.my_each {|x| total = yield(total, x)}
        # else args[0] == sym, initial == first elem, no block
        else
          total = self[0]
          self[1..-1].my_each { |elem| total = args[0].to_proc.call(total, elem) }
        end
      when 2
        # args: args[0] == initial, args[1] == sym, no block
        total = args[0]
        self.my_each { |elem| total = args[1].to_proc.call(total, elem) }
    end
    total
  end

  def multiply_els(arg)
    arg.my_inject(:*)
  end

end



##############
### TESTS ###
############


## MY_COUNT ##
# String manipulation in my_count will not work from file but will from irb???
# # "abcddde".my_count
# %w{a b c d d d e}.count
# %w{a b c d d d e}.my_count
# ("a".."c").count
# ("a".."c").my_count
# {"a" => 1, "b" => 2, "c" => 3}.count
# {"a" => 1, "b" => 2, "c" => 3}.my_count

# # "abcddde".my_count("d")
# %w{a b c d d d e}.count("d")
# %w{a b c d d d e}.my_count("d")
# ("a".."c").count("a")
# ("a".."c").my_count("a")

# # "abcddde".my_count { |element| element >= "c" }
# %w{a b c d d d e}.count { |element| element >= "c" }
# %w{a b c d d d e}.my_count { |element| element >= "c" }
# ("a".."c").count { |element| element >= "c" }
# ("a".."c").my_count { |element| element >= "c" }
# {"a" => 1, "b" => 2, "c" => 3}.count { |element, index| element >= "c" }
# {"a" => 1, "b" => 2, "c" => 3}.my_count { |element, index| element >= "c" }

## MY_MAP ##
# #
# # takes block
# #
# [1, 2, 3].my_map {|x| x*x}
# ("a".."c").my_map {|x| x*2}
# {"a" => 100, "b" => 200, "c" => 300}.my_map {|key, value| key*2}
# {"a" => 100, "b" => 200, "c" => 300}.my_map {|key, value| value*value}
# #
# # takes proc
# #
# multiply = Proc.new {|x| x*2}
# [1, 2, 3].my_map(multiply)
# ("a".."c").my_map(multiply)
# multiply = Proc.new {|key, value| key*2}
# {"a" => 100, "b" => 200, "c" => 300}.my_map(multiply)
# #
# # takes proc/block
# # block
# #
# # AS ABOVE
# #
# # proc
# #
# multiply = Proc.new {|x| x*2}
# [1, 2, 3].my_map(&multiply)
# ("a".."c").my_map(&multiply)
# multiply = Proc.new {|key, value| key*2}
# {"a" => 100, "b" => 200, "c" => 300}.my_map(&multiply)

## MY_INJECT ##
# # when 0
# [1, 2, 3].my_inject {|tot, x| tot * x}
# [0, 2, 3].my_inject {|tot, x| tot * x}
# [2, 2, 3].my_inject {|tot, x| tot * x}
# [1, 2, 3].my_inject {|tot, x| tot + x}
# [0, 2, 3].my_inject {|tot, x| tot + x}
# [2, 2, 3].my_inject {|tot, x| tot + x}
# # when 1, block
# [1, 2, 3].my_inject(1) {|tot, x| tot * x}
# [1, 2, 3].my_inject(0) {|tot, x| tot * x}
# [1, 2, 3].my_inject(2) {|tot, x| tot * x}
# [1, 2, 3].my_inject(1) {|tot, x| tot + x}
# [1, 2, 3].my_inject(0) {|tot, x| tot + x}
# [1, 2, 3].my_inject(2) {|tot, x| tot + x}
# # when 1, no block
# [1, 2, 3].my_inject(:*)
# [1, 2, 3].my_inject(:+)
# [24, 6, 2].my_inject(:/)
# [9, 3, 3].my_inject(:-)
# # when 2
# [1, 2, 3].my_inject(1, :*)
# [1, 2, 3].my_inject(0, :+)
# [6, 2, 1].my_inject(36, :/)
# [1, 2, 3].my_inject(12, :-)

