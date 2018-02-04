# Have to do some tricky manipulation because of floating point imprecision
# tried BigDecimal but couldn't get it to work
# => multiply by 10 instead ... I believe this is called fixed-point arithmetic

def ftoc(fahr)
	celc = (((fahr*10) - 320).to_f) / 18
end
def ctof(cel)
	fahr = (((cel*18) + 320).to_f) / 10
end

# Hmmm, turns out I made this a lot harder than it needed to be!!!
# But reminded me floats can be very tricky!!!

# def ftoc(fahr)
#   (fahrenheit - 32.0) * (5.0 / 9.0)
# end
# def ctof(cel)
#   cel * (9.0 / 5.0) + 32.0
# end

