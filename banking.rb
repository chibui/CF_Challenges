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
  def initialize(accountnumber, balance)
    @accountnumber = accountnumber
    @balance = balance
  end
  attr_accessor :accountnumber, :balance
  def deposit(money)
    @balance = @balance + money.to_f
  end
  def withdraw(money)
    @balance = @balance - money.to_f
  end
  def to_s
    puts "In #{@accountnumber}, there is $#{@balance}"
  end
end

bankalex = BankAccount.new(1234567890,1000)

alex = Customer.new("Alex", "fake@yahoo.com", bankalex, "666 Sky Av", 2357111317)

puts "Welcome to BestBank App\nWhat can we do for you?"
puts "1. Deposit\n2. Withdraw\n3. See your details\n4.Exit"
option = gets.chomp.to_i
case option
when 1
  puts "How much would you like to deposit ?"
  dep = gets.chomp.to_i
  if dep >= 0
    alex.account.deposit(dep)
    puts "#{dep} was deposited"
    puts "Balance remaining: #{alex.account.balance}"
  else
    puts "Incorrect input, Amount should be positive"
    puts "Try again"
  end
when 2
  puts "how much would you like to withdraw ?"
  with = gets.chomp.to_i
  if alex.account.balance <= 0
    puts "You have no money, Idiot"
  else
    if with >= 0
      alex.account.withdraw(with)
      puts "#{with} was withdrawn"
      puts "Balance remaining: #{alex.account.balance}"
    else
      puts "Incorrect input, Amount should be positive"
      puts "Try again"
    end
  end
when 3
  puts "Account number: #{alex.account.accountnumber}"
  puts "Balance: #{alex.account.balance}"
when 4
  puts "Thank you for using our service"
else
  puts "Incorrect input"
end
