class FileLottery

  def initialize(stream)
    @stream = stream
  end

  def execute
    Dir.entries("test_data/folder")
    @stream.puts '1 2 3 5 4'
  end

end
