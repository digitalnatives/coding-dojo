class FileLottery

  def initialize(stream)
    @stream = stream
  end

  def execute
    result = random(Dir.entries("test_data/folder").sort)
    result -= [".", ".."]
    @stream.puts result.join(" ")
  end

  def random(entries)
    entries.shuffle
  end

end
