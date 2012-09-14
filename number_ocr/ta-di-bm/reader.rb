mapping = {
  ' . . ....' => 0,
  '     .  .' => 1,
  ' .  .... ' => 2,
  ' .  .. ..' => 3,
  '   ...  .' => 4,
  ' . ..  ..' => 5,
  ' . .. ...' => 6,
  ' .   .  .' => 7,
  ' . ......' => 8,
  ' . ... ..' => 9,
}


seq = [[]]
File.open('input.txt', 'r').each_line do |line|
  if line =~ /^$/
    seq << []
    next
  end
  seq.last << line.chomp.gsub!(/[^\s]/, '.')
end

numbers = []
seq.each do |s|
  numbers << []
  (0..24).step(3) { |i| numbers.last << mapping[s.map { |j| j[i..(i+2)] }.join] }
  numbers[-1] = numbers.last.join.to_i
end

puts numbers

@seq = seq
@numbers = numbers
#   seq[i] << line[0..-2].split('').map{|c| c == ' ' ? 0 : 1 }
#   seq[i].last << 0 if seq[i].last.count == 26
# end

# seq_digits = []
# seq.each do |line|
#   seq_digits << []
#   (0..2).each do |i|
#     while l = line[i].shift(3)
#       seq_digits.last << l
#     end
#   end
# end
