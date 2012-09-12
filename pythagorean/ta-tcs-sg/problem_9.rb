# a + b + c = 1000
# a**2 + b**2 = c**2
# a < b < c

3.upto(1000) do |c|
  puts c
  2.upto(999) do |b|
    1.upto(998) do |a|

      next unless a+b+c == 1000
      next unless a**2 + b**2 == c**2
      next unless a < b && b < c
      puts "a: %d b: %d c: %d" % [a, b, c]
      puts "product: #{a*b*c}"
      exit
    end
  end
end
