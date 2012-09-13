def parseOCR(text)
	regexp = /(?-mix:(\s_\s\|\s\|\|_\|)|(\s{5}\|\s{2}\|)|(\s_\s{2}_\|{2}_\s)|(\s_\s{2}_\|\s_\|)|(\s{3}\|_\|\s{2}\|)|(\s_\s\|_\s{2}_\|)|(\s_\s\|_\s\|_\|)|(\s_\s{3}\|\s{2}\|)|(\s_\s\|_\|\|_\|)|(\s_\s\|_\|\s_\|)|)/
	result = []
	text.split("\n").each_slice(4) do |block|
		y = ''
		while block[0].length > 0 do
			block.each do |line|
				line.gsub!(/^.{3}/) { |m| y+=m; ''}
			end
		end
		z = ''
		y.scan(regexp) { |*args|z += args[0].find_index { |x| not x.nil? }.to_s }
		result.push z
	end
	result
end
puts parseOCR(File.read('code.txt'))