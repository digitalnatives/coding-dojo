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
  lines.each do |line|
    puts line.inspect
    line.split( /.{3}/ ) do |triplet|
      puts triplet.inspect
    end
  end
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


