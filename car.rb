class Car
  def initialize(make, age, topspeed, gasTankSize, permeter)
    @make = make
    @age = age
    @topspeed = topspeed
    @gasTankSize = gasTankSize
    @permeter = permeter
    @fuel = @gasTankSize
  end
  attr_accessor :make, :topspeed, :gastank, :age, :fuel, :permeter

  def depleteFuel(km)
    @fuel = @fuel - km * @permeter
  end
end
class Driver
  def initialize(name, car, age, contact)
    @name = name
    @car = car
    @age = age
    @contact =contact
  end
  attr_accessor :name, :car, :age, :contact
end

audir8 = Car.new("Audi", 3, 300, 200)
hamilton = Driver.new("lewis", audir8, 30, 123456)

puts "Do you want the car make or the age ?"
puts "1. Car make"
puts "2. Car age"
answer = gets.chomp.to_i

if answer == 1
  puts "The make of the car is #{hamilton.car.make}"
elsif answer == 2
  puts "The car is #{hamilton.car.age} years old"
end

puts hamilton.car.depleteFuel
