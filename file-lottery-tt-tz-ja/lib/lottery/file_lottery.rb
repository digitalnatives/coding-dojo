class FileLottery
	def self.reads(path)
	path ||= ""
		Dir.glob(path + "/*")
	end
	def self.randomize(arr)
		arr.shuffle
	end
	def self.print(arr)
		arr.join(",")
	end
end
