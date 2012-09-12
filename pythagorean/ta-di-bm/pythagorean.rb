class Pythagorean
  def self.run
    b=2
    c=3
    
    counter = 0
    
    b.upto(1000) do |act_b|
      (1000-2*act_b).upto(1000) do |act_c|
        act_a = 1000-act_b-act_c
        break if act_a < 0
        
        counter+=1
        
        if (1000-act_b-act_c)**2 + act_b**2 == act_c**2 && act_a < act_b && act_b < act_c
          puts "a: #{act_a}"
          puts "b: #{act_b}"
          puts "c: #{act_c}"
          puts "a+b+c: #{act_a + act_b + act_c}"
          puts "abc: #{act_a * act_b * act_c}"
          puts "counter: #{counter}"
          
          exit
        end
      end
    end
    
  end
end

Pythagorean.run

=begin
a+b+c=1000
a2+b2=c2

a=1000-b-c

1000-b-c < b
1000-c < 2b
-c < 2b - 1000
c > 1000 - 2b

(1000-b-c)2+b2 = c2
=end