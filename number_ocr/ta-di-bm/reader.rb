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

seq, numbers = [[]], []
File.open('input.txt', 'r').each_line do |line|
  if line =~ /^$/
    seq << []
    next
  end
  seq.last << line.chomp.gsub!(/[^\s]/, '.')
end

seq.each do |s|
  numbers << []
  (0..24).step(3) { |i| numbers.last << mapping[s.map { |j| j[i..(i+2)] }.join] }
  numbers[-1] = numbers.last.join.to_i
end
puts numbers