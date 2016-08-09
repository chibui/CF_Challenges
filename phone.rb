class Phone
  def initialize(brand, age, price, opSystem, battery, perhour)
    @brand = brand
    @age = age
    @price = price
    @OS = opSystem
    @battery = battery
    @perhour = perhour
    @currentbattery = @battery
  end

  attr_accessor :brand, :age, :price, :opSystem, :battery, :perhour, :currentbattery

  def depletebattery(hours_used)
    @currentbattery = @currentbattery - @perhour * hours_used
  end

end

class User
  def initialize(name, age, phone, about)
    @name = name
    @age = age
    @phone = phone
    @about = about
  end

  attr_accessor :name, :age, :phone, :about
end

alexsphone = Phone.new("Moto X Style", 1.5, 500, "Android", 3000, 800)
alex = User.new("Alex", "25", alexsphone, "I prefer Android")

theIphone = Phone.new("iPhone 6s", 0.5, 1200, "iOS", 2100, 800)
jenny = User.new("Jennifer", 18, theIphone, "iOS is better than Android")

puts "#{alex.name}'s phone is a #{alex.phone.brand} and it costs #{alex.phone.price}"
puts alex.about
alex.phone.depletebattery(2)
puts "You can use your phone for #{alex.phone.battery / alex.phone.perhour.to_f} hours"
puts "\n"
puts "#{jenny.name}'s phone is a #{jenny.phone.brand} and it costs #{jenny.phone.price}"
puts jenny.about
puts "You can use your phone for #{jenny.phone.battery / jenny.phone.perhour.to_f} hours"
puts "\n"

# def openInYoutube(artist, song)
#   url = "https://www.youtube.com/results?search_query=#{artist.gsub(" ", "+")}+#{song.gsub(" ", "+")}"
#   puts url
#   system "open #{url}"
# end
