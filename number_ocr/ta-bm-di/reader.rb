seq = [[]]
i = 0
File.open('numbers.txt', 'r').each_line do |line|
  if line =~ /^$/
    i+=1
    seq[i] = []
    next
  end
  seq[i] << line[0..-2].split('').map{|c| c != ' '}
  seq[i].last << false if seq[i].last.count == 26
end

seq_digits = []
seq.each do |line|
  seq_digits << []
  (0..2).each { |l| seq_digits.last << line[l][0..2] }
end
