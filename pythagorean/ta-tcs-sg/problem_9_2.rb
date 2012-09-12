# a + b + c = 1000
# a**2 + b**2 = c**2
# a < b < c

1000.times do |c|
  tmp = c**2+2000*c-1000000
  next if tmp < 0
  a =  (Math.sqrt(tmp)-c+1000)/2
  b = -(Math.sqrt(tmp)+c-1000)/2
  puts "a: %d b: %d c: %d" % [a, b, c]
  next unless a < b && b < c
  puts "product: #{a*b*c}"
  exit
end

