# def even_odd(number)
#   unless number.is_a? Numeric
#     return "A number was not entered."
#   end

#   if number % 2 == 0
#     "That is an even number."
#   else
#     "That is an odd number."
#   end
# end

# puts even_odd(20) #=>  That is an even number.
# puts even_odd("Ruby") #=>  A number was not entered.

# a = 14

# def change_val(number = 2)
#   puts "Hello"
# end


# change_val

# undef change_val

# change_val

def greet(name)
  "Hi, " + name + "!"
end

def greet(name)
  "Hey, " + name + "!"
end

puts greet("Andy")

$car_color = 'red'

def multiply(num1, num2)
  puts $car_color
  num1 * num2
end

puts "thing".is_a?(Numeric)
puts multiply(5,5)

multiply = 5

puts multiply