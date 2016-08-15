require 'encryptor'
require 'securerandom'
require 'paint'
require 'terminal-table'
require 'highline/import'

class User
  def initialize(name, email, safe)
    @name = name
    @email = email
  end
end

class Account
  def initialize(name, username, password)
    @name = name
    @username = username
    @password = password
    @string_acc = "#{@name},#{@username}, #{@password}"
  end

  attr_accessor :name, :username, :password, :string_acc
end

class Safe
  def initialize(pass)
    @safearray= []
    #each safe has only one IV(Initialization) and one key
    @iv = SecureRandom.random_bytes(12)
    # @secret_key = SecureRandom.random_bytes(32)

    @pass = pass
    # generates a key with a password when encrypt or decrypt is used, one salt per safe
    @salt = OpenSSL::Random.random_bytes(16) #store this with the generated value
    @iter = 20000
    @digest = OpenSSL::Digest::SHA256.new
    @len = @digest.digest_length
    @secret_key = OpenSSL::PKCS5.pbkdf2_hmac(@pass, @salt, @iter, @len, @digest)
  end

  attr_accessor :accounts, :pass, :safearray

  def encryptsafe
    unencrypted_safe = @safearray  # transfer arrays
    @safearray = []
    unencrypted_safe.each do |data|  # data that are not encrypted
      @safearray << Encryptor.encrypt(value: data.to_s, key: @secret_key, iv: @iv)
    end
    #safearray is now encrypted
  end

  def decryptsafe
    encrypted_safe = @safearray #transfer arrays
    @safearray = []
    encrypted_safe.each do |data_en| # encrypt data
       @safearray << Encryptor.decrypt(value: data_en, key: @secret_key, iv: @iv)
    end
  end

  def addAccount(account)
    @safearray = @safearray << account
  end

end

def logo
  system 'clear'
  puts "=" * 20
  puts Paint["WELCOME TO BESTSAFE", :red, :bright]
  puts "=" * 20
  puts "\n"
end

def mainMenu
  puts "Please select from the options below:\n"
  puts "1. Enter in your BestSafe"
  puts "2. Add data in your safe"
  puts "3. Exit"
end

#best way to compare 2 values. Compare bytes.
# Cause "==" short-circuits on evaluation, and is therefore vulnerable to timing attacks
def eql_time_cmp(a, b) # equal time comparison
  unless a.length == b.length
    return false
  end
  cmp = b.bytes.to_a
  result = 0
  a.bytes.each_with_index {|c,i|
    result |= c ^ cmp[i]  # input 0 if c = cmp[i], 1 if c != cmp[i]
  }
  result == 0
end

def red(string)
  Paint[string, :red, :bold]
end

googleaccount = Account.new("Google", "BestGoogleUser", 12345)
ebayaccount = Account.new("eBay", "BesteBayUser", 67890)
westpaccard = Account.new("Westpac","918273645", "a1b2c3")
facebookaccount = Account.new("Facebook", "BestFacebookUser", "zuckerberg")

alexsafe = Safe.new('Hello')

alexsafe.addAccount(googleaccount.string_acc)
alexsafe.addAccount(ebayaccount.string_acc)
alexsafe.addAccount(westpaccard.string_acc)
alexsafe.addAccount(facebookaccount.string_acc)

# alexsafe.decryptsafe('bye')
alex = User.new("alex", "alex@fake.com", alexsafe)
alexsafe.encryptsafe
exit = false
until exit do
  logo
  mainMenu
  command = gets.chomp

  case command
    when "1"
      logo
      puts "Enter your password:"
      password = ask("Password: ") { |q| q.echo = "*" } # input is replaced by *

      if eql_time_cmp(alexsafe.pass, password)
        alexsafe.decryptsafe
        system 'clear'
        puts "This is what is in your safe:"
        rows = []
        alexsafe.safearray.each_with_index do |string, index|
          index % 2 == 0 ? colour = :magenta : colour = "gold"
          rows << Paint[string, colour].split(",")
          rows << :separator
        end
        rows << ["", "ADD MORE", ""]
        table = Terminal::Table.new :headings => [red('Account'), red('Username'), red('Password')], :rows => rows
        puts table
        puts "Press Enter to continue"
        gets
        alexsafe.encryptsafe

      else
        puts "Incorrect Password\n"
        puts "Your safe is still encrypted...\n Look..."
        # show encrypted data
        alexsafe.safearray.each do |element|
          puts element
        end
        puts "Press enter to continue"
        gets
      end
    when "2"
      puts "Account:"
      account = gets.chomp
      puts "Username:"
      username = gets.chomp
      puts "Password"
      pass2 = gets.chomp
      newaccount = Account.new(account,username,pass2)
      alexsafe.decryptsafe
      alexsafe.addAccount(newaccount.string_acc)
      alexsafe.encryptsafe

    when "3"
      exit = true
      puts Paint["Thank you for using BESTSAFE", :bold]
    else
      puts "Wrong command"
  end


end
