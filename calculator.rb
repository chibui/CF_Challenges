def add(a,b)
  a + b
end

def subtract(a,b)
  a-b
end

def multiply(a,b)
  a*b
end

def divide(a,b)
  a/b
end

puts "Welcome to RubyCalc"
print "Enter first number: "
n1 = gets.chomp.to_i
print "Enter operation (+, -, *, /): "
operation = gets.chomp
print "Enter second number: "
n2 = gets.chomp.to_i

if operation == "+"
  result = add(n1,n2)
elsif operation == "-"
  result = subtract(n1,n2)
elsif operation == "*"
  result = multiply(n1,n2)
elsif operation == "/"
  result = divide(n1,n2)
else
  puts "choose one operation"
end

puts "The result is: #{result}"
