def add(a,b)
  a + b
end

def subtract(a,b)
  a - b
end

def multiply(a,b)
  a * b
end

def divide(a,b)
  a / b
end

def output(result)
  puts "The result is #{result}"
end

puts "Welcome to RubyCalc"
print "Enter first number: "
a = gets.chomp.to_i
print "Enter operation (+, -, *, /): "
operator = gets.chomp
print "Enter second number: "
b = gets.chomp.to_i

if operator == "+"
  output(add(a,b))
elsif operator == '-'
  output(subtract(a,b))
elsif operator == '*'
  output(multiply(a,b))
elsif operator == '/'
  output(divide(a,b))
end
