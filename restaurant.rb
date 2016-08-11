require 'paint'
require 'terminal-table'

class Restaurant
  def initialize(name, address, menu)
    @name = name
    @address = address
    @menu = menu
  end

  def showMenu
    puts "\n"
    puts "=== Welcome to #{Paint[@name, :red]} at #{Paint[@address, :blue]} ==="
    puts "========== Menu Options =========="
    puts "What would you like to order? Enter the Number"
    puts "=" * 30
    i = 0
    row = []

    @menu.dishes.each do |dish|
      i = i + 1
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

class Menu
  def initialize(name)
    @name = name
    @dishes = []
  end
  attr_accessor :name, :dishes

  def add_dish(newDish)
    @dishes << newDish
  end
end

class Dish
  def initialize(name, price)
    @name = name
    @price  = price
  end
  attr_accessor :name, :price
end

class Customer
  def initialize(name, age)
    @name = name
    @age = age
    @order = []
  end

  attr_accessor :name, :age, :order

  def add_to_order(dish)
    @order << dish
  end
end

garlicbread = Dish.new("Garlic Bread", 6)
ceasarsalad = Dish.new("Ceasar Salad", 12)
bolognese = Dish.new("Bolognese", 15)

bestmenu = Menu.new("Italian")
bestmenu.add_dish(bolognese)
bestmenu.add_dish(ceasarsalad)
bestmenu.add_dish(garlicbread)
bestrestaurant = Restaurant.new("Best Restaurant", "666 Sky Av", bestmenu)

alex = Customer.new("Alex", 25)

exit = false
until exit do
  bestrestaurant.showMenu
  command = gets.chomp.to_i
  number_of_dishes = bestmenu.dishes.size

  if command == number_of_dishes + 1
    puts "Thank you for coming to #{bestrestaurant.name}"
    exit = true
  elsif (1..number_of_dishes).include?(command)
    print "You ordered "
    index = command - 1
    puts "#{bestmenu.dishes[index].name}, Price = $#{bestmenu.dishes[index].price}"
    alex.add_to_order(bestmenu.dishes[index])
    puts "Thank you for ordering with us"
    sleep(1)
  else
    puts "Incorrect input"
  end
  system 'clear'
end

#alex.order array of dishes alex ordered
total_bill = 0
alex.order.each do |dish|
  total_bill = total_bill + dish.price
end

puts "The total bill is $#{total_bill} "
