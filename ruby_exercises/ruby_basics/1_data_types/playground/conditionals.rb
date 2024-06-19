def return_false
  false
end

if return_false
  puts "It's false!"
else
  puts "It's true!"
end

puts "I am the first case" if 1 < 2   

if not 5 < 10 or 1 < 2
  puts "10 is not less than 5"
end

grade = 'A'

did_i_pass = 
  case grade #=> create a variable `did_i_pass` and assign the result of a call to case with the variable grade passed in
    when 'A' then "Hell yeah!"
    when 'D' then "Don't tell your mother."
    else "'YOU SHALL NOT PASS!' -Gandalf"
  end

puts did_i_pass

if x = false
  puts "how can this be true?"
else
  puts "it is not true"
end

planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

for planet in planets
  puts planet
end