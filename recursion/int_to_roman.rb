# Use the roman_mapping hash to define a recursive method that converts an integer to a Roman numeral.

# # non-recursive version
# def int_to_roman(arg, roman_num = "")
#   roman_mapping = {
#   1000 => "M",
#   900 => "CM",
#   500 => "D",
#   400 => "CD",
#   100 => "C",
#   90 => "XC",
#   50 => "L",
#   40 => "XL",
#   10 => "X",
#   9 => "IX",
#   5 => "V",
#   4 => "IV",
#   1 => "I"
#   }
#   roman_mapping.each_pair do |key, value|
#     roman_num += (value * arg.divmod(key)[0])
#     arg -= (key * arg.divmod(key)[0])
#     (arg % key != 0) ? (arg = arg % key) : (return roman_num)
#   end
# end


# recursive version
def int_to_roman(arg, roman_num = "", ctr = 0)
  roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
  }
  curr_value = roman_mapping.values[ctr]
  curr_key = roman_mapping.keys[ctr]
  roman_num += (curr_value * arg.divmod(curr_key)[0])
  arg -= (curr_key * arg.divmod(curr_key)[0])
  (arg % curr_key != 0) ? (arg = arg % curr_key) : (return roman_num)
  int_to_roman(arg, roman_num, ctr+1)
end

puts int_to_roman(1941)