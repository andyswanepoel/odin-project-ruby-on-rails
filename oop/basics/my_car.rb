# # frozen_string_literal: true

# # Test class
# class TestClass
#   @@test = 0
# end

# # This is Vehicle
# class Vehicle
#   attr_accessor :color, :model, :speed
#   attr_reader :year

#   class << self
#     attr_accessor :vehicles

#     def gas_mileage(distance_traveled, gas_used)
#       distance_traveled / gas_used
#     end

#     def increment_vehicles
#       # @vehicles ||= 1
#       @vehicles += 1
#     end
#   end

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     self.class.increment_vehicles
#   end

#   def speed_up
#     self.speed += 1
#   end

#   def break
#     self.speed = [speed - 1, 0].max
#   end

#   def turn_off
#     self.speed = 0
#   end

#   def spray_paint(color)
#     self.color = color
#   end
# end

# # This is MyCar
# class MyCar < Vehicle
#   attr_accessor :doors

#   def initialize(year, color, model, doors)
#     puts(year, color, model, doors)
#     super(year, color, model)
#     self.doors = doors
#   end
# end

# # This is MyTruck
# class MyTruck < Vehicle
#   attr_accessor :can_tow

#   def initialize(year, color, model, can_tow)
#     super(year, color, model)
#     self.can_tow = can_tow
#   end
# end

# my_car = MyCar.new(1984, 'blue', 'Chevy Silverado', 2)
# # # my_truck_1 = MyTruck.new(1984, 'blue', 'Chevy Silverado', true)
# # # my_truck_2 = MyTruck.new(1984, 'blue', 'Chevy Silverado', true)
# # # my_truck_3 = MyTruck.new(1984, 'blue', 'Chevy Silverado', true)
# # puts Vehicle.number_of_vehicles
# puts Vehicle.vehicles
# p my_car
# # my_vehicle.total_vehicles
# # puts Vehicle.vehicles
# # puts MyCar.ancestors
# # my_car = MyCar.new(1990, 'red', 'Toyota Corolla', 2)

# # puts my_car.year
# # puts my_car.color
# # puts my_car.model
# # puts my_car.speed
# # my_car.break
# # puts my_car.speed
# # my_car.speed_up
# # my_car.speed_up
# # my_car.speed_up
# # puts my_car.speed
# # my_car.break
# # puts my_car.speed
# # my_car.turn_off
# # puts my_car.speed

# # my_car.spray_paint('blue')
# # puts my_car.color
# # puts my_truck.color

# # puts my_car

# # Vehicle
# class Vehicle
#   @vehicles = 0

#   class << self
#     attr_accessor :vehicles

#     def gas_mileage(distance_traveled, gas_used)
#       distance_traveled / gas_used
#     end

#     def total_vehicles
#       @vehicles ||= 0
#     end

#     def increment_vehicles
#       @vehicles ||= 0
#       @vehicles += 1
#     end
#   end

#   attr_accessor :color, :model, :speed
#   attr_reader :year

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     self.class.increment_vehicles
#   end
# end

# class Car < Vehicle
#   @cars = 0

#   class << self
#     attr_accessor :cars

#     def total_cars
#       @cars ||= 0
#     end

#     def increment_cars
#       @cars ||= 0
#       @cars += 1
#     end
#   end

#   def initialize(year, color, model)
#     super(year, color, model)
#     self.class.increment_cars
#   end
# end

# car1 = Car.new(2022, 'red', 'Toyota')
# car2 = Car.new(2023, 'blue', 'Honda')

# puts "Total Vehicles: #{Vehicle.total_vehicles}"  # Outputs: Total Vehicles: 2
# puts "Total Cars: #{Car.total_cars}"              # Outputs: Total Cars: 2
#
#
#
#
#
#
#
#
# Vehicle
class Vehicle
  @vehicles = 0

  class << self
    attr_accessor :vehicles

    def gas_mileage(distance_traveled, gas_used)
      distance_traveled / gas_used
    end

    def total_vehicles
      @vehicles ||= 0
    end

    def increment_vehicles
      @vehicles ||= 0
      @vehicles += 1
    end
  end

  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    self.class.increment_vehicles
  end
end

class Car < Vehicle
  @cars = 0

  class << self
    attr_accessor :cars

    def total_cars
      @cars ||= 0
    end

    def increment_cars
      @cars ||= 0
      @cars += 1
    end
  end

  def initialize(year, color, model)
    super(year, color, model)
    self.class.increment_cars
  end
end

car1 = Car.new(2022, 'red', 'Toyota')
car2 = Car.new(2023, 'blue', 'Honda')

puts "Total Vehicles: #{Vehicle.total_vehicles}"  # Outputs: Total Vehicles: 2
puts "Total Cars: #{Car.total_cars}"              # Outputs: Total Cars: 2
