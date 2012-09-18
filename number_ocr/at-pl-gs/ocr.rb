require 'active_support'

numbers = {
  1 => ['   ',
        '  |',
        '  |'],
  2 => [' _ ',
        ' _|',
        '|_ ']
}

# ["    _  _  _  _  _  _  _  _ ",
#  "  | _| _||_||_ |_   ||_||_|",
#  "  ||_  _| _| _||_|  ||_||_|"]
def recognize_line( lines )
  chars = []
  lines.each do |line|
    char = 0
    line.split(//).each_slice( 3 ) do |triplet|
      chars[char] ||= []
      chars[char] << triplet.join
      char += 1
    end
  end
  puts chars.join.inspect
end

File.open ARGV[0], 'r' do |f|
  line_rows = []
  counter = 0
  f.each_line do |line|
    unless line.strip == ''
      line_rows[counter] ||= []
      line_rows[counter] << line.gsub("\n", '')
    else
      counter += 1
    end
  end

  line_rows.each do |line|
    recognize_line( line )
  end
end


