# frozen_string_literal: true

# This is a GoodDog
class GoodDog
  # This is a way to have both a getter and a setter method in one
  attr_accessor :name, :height, :weight

  # This is a constant, it can't be reassigned
  DOG_YEARS = 7
  # This is a class variable
  @@number_of_dogs = 0

  # Every object comes with a to_s method, which we can override
  def to_s
    "This dog's name is #{name} and it is #{height} tall."
  end

  # This is a class method. You have to use 'self.[method_name]'
  # It can be called on the class, i.e., GoodDog.what_am_i
  def self.what_am_i
    "I'm a GoodDog class"
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def initialize(name, height, weight)
    @@number_of_dogs += 1
    self.name = name
    self.height = height
    self.weight = weight
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end

  # You need to use self.{variable} in this, or Ruby will think you're creating local variables
  def change_info(name, height, weight)
    self.name = name
    self.height = height
    self.weight = weight
  end

  def speak
    # When we use the attr_accessor, we can access the variable name directly without the @
    # It will just call the "name" method, which returns the name
    "#{name} says arf!"
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
russ = GoodDog.new('Rusty', '30 inches', '30 lbs')
minnie = GoodDog.new('Minnue', '30 inches', '30 lbs')
puts sparky.name
puts sparky.speak
puts russ.speak
puts minnie.speak
sparky.name = 'Spartacus'
puts sparky.name
puts sparky.speak
puts sparky.info
puts GoodDog.what_am_i
puts GoodDog.total_number_of_dogs

p sparky
