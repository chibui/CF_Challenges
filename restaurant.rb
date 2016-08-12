require 'paint'
require 'terminal-table'

# create a class restaurant
class Restaurant
  def initialize(name, address, menu)
    @name = name
    @address = address
    @menu = menu
  end

# create a method to show the menu of the restaurant
  def showMenu
    puts "\n"
    puts "==== Welcome to #{Paint[@name, :red]} at #{Paint[@address, :blue]} ===="
    puts "==========++++++++ Menu Options ++++++++=========="
    puts "\nWhat would you like to order? Enter the Number"
    puts "=" * 50
    i = 0
    row = []

    @menu.dishes.each do |dish|
      i += 1
      row << [i, "#{dish.name}", dish.price]
      row << :separator
    end
    row << ["#{@menu.dishes.size + 1}", "Exit", "Free"]
    table = Terminal::Table.new :title => "THE MENU", :headings => ["Number", "Dish", "Price"], :rows => row
    table.align_column(2, :right)
    puts table
  end

  attr_accessor :name, :address, :menu
end

# create the menu of a restaurant which contains dishes
class Menu
  def initialize(name)
    @name = name
    @dishes = []
  end
  attr_accessor :name, :dishes

# add dishes to the Menu
  def add_dish(newDish)
    @dishes << newDish
  end
end

#create the dish class which has a name and a price
class Dish
  def initialize(name, price)
    @name = name
    @price  = price
  end
  attr_accessor :name, :price
end

# create the customer
class Customer
  def initialize(name, age)
    @name = name
    @age = age
    @order = []
  end

  attr_accessor :name, :age, :order

# for every dish he orders, the dish is added to an array
  def add_to_order(dish)
    @order << dish
  end
end

garlicbread = Dish.new("Garlic Bread", 6)
ceasarsalad = Dish.new("Ceasar Salad", 12)
bolognese = Dish.new("Bolognese", 15)
# chilliprawnpizza = Dish.new("Chilli Prawn", 13)

bestmenu = Menu.new("Italian")
bestmenu.add_dish(bolognese)
bestmenu.add_dish(ceasarsalad)
bestmenu.add_dish(garlicbread)
# bestmenu.add_dish(chilliprawnpizza)

bestrestaurant = Restaurant.new("Best Restaurant", "666 Sky Av", bestmenu)

alex = Customer.new("Alex", 25)
time = 0.5

exit = false
until exit do
  bestrestaurant.showMenu
  command = gets.chomp.to_i
  number_of_dishes = bestmenu.dishes.size

  if command == number_of_dishes + 1
    puts "Thank you #{alex.name} for coming to #{bestrestaurant.name}"
    sleep (time)
    exit = true
  elsif (1..number_of_dishes).include?(command)
    print "#{alex.name} ordered "
    index = command - 1
    puts "#{bestmenu.dishes[index].name}, Price = $#{bestmenu.dishes[index].price}"
    alex.add_to_order(bestmenu.dishes[index])
    puts "Thank you for ordering with us"
    sleep(time)
  else
    puts "Incorrect input"
    sleep(time)
  end
  system 'clear'
end

#alex.order array of Object dishes alex ordered
total_bill = 0
dishes_ordered = []
alex.order.each do |dish|
  total_bill = total_bill + dish.price
  dishes_ordered << dish.name
end

puts "#{alex.name} ordered: "
alex.order.each { |dish| puts "#{dish.name} $#{dish.price}"}
puts "The total bill for #{alex.name} is $#{total_bill} "
