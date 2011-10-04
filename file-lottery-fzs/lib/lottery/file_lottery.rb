class FileLottery

  def initialize(stream)
    @stream = stream
  end

  def execute( dir_path )
    unless File.directory?( dir_path )
      @stream.puts ""
      return true
    end

    result = random(Dir.entries(dir_path).sort)
    result -= [".", ".."]
    @stream.puts result.join(" ")
    true
  end

  def random(entries)
    entries.shuffle
  end

end
