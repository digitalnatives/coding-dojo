class FileLottery

  def initialize(stream)
    @stream = stream
  end

  def execute( dir_path )
    result = random(Dir.entries(dir_path).sort)
    result -= [".", ".."]
    @stream.puts result.join(" ")
    true
  end

  def random(entries)
    entries.shuffle
  end

end
