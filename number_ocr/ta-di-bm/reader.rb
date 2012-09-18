# encoding: utf-8
# TODO the mapping can remains dictinctive even if we remove the first 3 columns
mapping, seq = {
  ' ☻ ☻ ☻☻☻☻' => 0,
  '     ☻  ☻' => 1,
  ' ☻  ☻☻☻☻ ' => 2,
  ' ☻  ☻☻ ☻☻' => 3,
  '   ☻☻☻  ☻' => 4,
  ' ☻ ☻☻  ☻☻' => 5,
  ' ☻ ☻☻ ☻☻☻' => 6,
  ' ☻   ☻  ☻' => 7,
  ' ☻ ☻☻☻☻☻☻' => 8,
  ' ☻ ☻☻☻ ☻☻' => 9,
}, [[]]
File.open('input.txt', 'r').each_line { |line| line =~ /^$/ ? seq << [] : seq.last << line.chomp.gsub!(/[^\s]/, '☻') }
puts seq.map { |s| (0..24).step(3).map { |i| mapping[s.map { |j| j[i..(i+2)] }.join] }.join.to_i }
