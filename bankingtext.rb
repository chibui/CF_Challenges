class Customer
  def initialize(name, email, account, address, contact)
    @name = name
    @email = email
    @account = account
    @address = address
    @contact = contact
  end
  attr_accessor :name, :email, :account, :address, :contact
end

class BankAccount
  def initialize(accountnumber)
    @accountnumber = accountnumber
    # @balance = 1000
    @filename = "Balance_#{@accountnumber}"
    File.open(@filename, "w") { |file| file.puts 1000}
    # file = File.open(@filename, "w")
    # file.puts 1000
    # file.close
  end
  attr_accessor :accountnumber, :balance, :filename
  def deposit(money)
    #File.open(@filename, "r+") {|file| file.rewind file.write(file.read.to_i + money.to_i)}
    txt = File.open(@filename, "r+")
    newbalance = txt.read.to_i + money
    txt.rewind
    txt.write(newbalance)
    txt.close
  end
  def withdraw(money)
    txt = File.open(@filename, "r+")
    newbalance = txt.read.to_i - money
    txt.rewind
    txt.write(newbalance)
    txt.close
  end
  def viewbalance
    txt = File.open(@filename, "r+")
    txt.read
  end
end

bankalex = BankAccount.new(1234567890)
bankchi = BankAccount.new(987654321)

alex = Customer.new("Alex", "fake@yahoo.com", bankalex, "666 Sky Av", 2357111317)
chi = Customer.new("Chi", "chi@yahoo.au", bankchi, "666 Floor Av", 000000000)

while alex.account.balance != 0
  txt = open(alex.account.filename, "r")
  puts "Welcome to BestBank App\nWhat can we do for you?"
  puts "1. Deposit\n2. Withdraw\n3. See your details\n4. Exit"
  cool_line = "=" * 30
  incorrect_input = "Incorrect input\nTry again\n" + cool_line
  option = gets.chomp.to_i
  case option
  when 1
    puts "How much would you like to deposit ?"
    dep = gets.chomp.to_i
    if dep >= 0
      alex.account.deposit(dep)
      puts "#{dep} was deposited"
      print "Balance remaining: "
      puts alex.account.viewbalance
      puts cool_line
    else
      puts incorrect_input
    end
  when 2
    puts "how much would you like to withdraw ?"
    with = gets.chomp.to_i
    if with >= 0 && with < txt.read.to_i
      alex.account.withdraw(with)
      puts "#{with} was withdrawn"
      print "Balance remaining: "
      puts alex.account.viewbalance
      puts cool_line
    else
      puts incorrect_input
    end
  when 3
    puts "Account number: #{alex.account.accountnumber}"
    print "Balance: "
    puts txt.read
    puts  cool_line = "=" * 15
  when 4
    puts "Thank you for using our service\nThe best bank is BestBank"
    break
  else
    puts incorrect_input
  end
  txt.close
end
