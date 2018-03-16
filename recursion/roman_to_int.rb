# Use the roman_mapping hash to define a recursive method that converts a Roman numeral to an integer.

# # non-recursive version
# def roman_to_int (roman_num, num = 0)
# roman_mapping = {
#   "M" => 1000,
#   "CM" => 900,
#   "D" => 500,
#   "CD" => 400,
#   "C" => 100,
#   "XC" => 90,
#   "L" => 50,
#   "XL" => 40,
#   "X" => 10,
#   "IX" => 9,
#   "V" => 5,
#   "IV" => 4,
#   "I" => 1
#   }
#   roman_mapping.each_pair do |key, value|
#     while roman_num[0..(key.length - 1)] == key
#       num += value
#       roman_num = roman_num[key.length..-1]
#     end
#     return num if roman_num.length == 0
#   end
# end

# recursive
def roman_to_int (roman_num, num = 0, ctr = 0)
roman_mapping = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
  }
  curr_key = roman_mapping.keys[ctr]
  curr_value = roman_mapping.values[ctr]
  # while roman_num[0..(curr_key.length - 1)] == curr_key
  while roman_num.start_with? curr_key
    num += curr_value
    roman_num = roman_num[curr_key.length..-1]
  end
  return num if roman_num.length == 0
  roman_to_int(roman_num, num, ctr + 1)
end

roman_to_int("MCMDVI")