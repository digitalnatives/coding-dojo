module Ocr
  class Processor
    
    attr_accessor :input
    attr_accessor :numbers
    
    def self.run
      self.new.run
    end
    
    def initialize
      self.numbers = []
      self.input = File.read( File.join( File.dirname(__FILE__), "input.txt" ) )
    end
    
    def run
      line_num = 0
      
      self.numbers << Number.new
      input.each_line do |input_line|
        # init new number
        if input_line.strip == ""
          self.numbers << Number.new
          next
        end
        
        char_array = input_line.split("")[0,27]
        char_array.each_with_index do |char, index|
          digit_num = index/3
          self.numbers.last.digits[digit_num].add_char( char )
        end
        
        line_num += 1
      end
      
      puts input
      numbers.each do |number|
        puts number.to_i
      end
    end
  end
  
  class Number
    attr_accessor :digits
    
    def initialize
      self.digits = []
      
      1.upto(9) do
        self.digits << Digit.new
      end
    end
    
    def to_i
      s = ""
      self.digits.each do |digit|
        s += digit.to_i.to_s
      end
      s.to_i
    end
  end
  
  class Digit
    attr_accessor :lines

    def initialize
      self.lines = []
    end
    
    def add_char(char)
      lines << ( char != " " )
    end

    def to_i
      case lines
      when [false, true, false, true, false, true, true, true, true]
        0
      when [false, false, false, false, false, true, false, false, true]
        1
      when [false, true, false, false, true, true, true, true, false]
        2
      when [false, true, false, false, true, true, false, true, true]
        3
      when [false, false, false, true, true, true, false, false, true]
        4
      when [false, true, false, true, true, false, false, true, true]
        5
      when [false, true, false, true, true, false, true, true, true]
        6
      when [false, true, false, false, false, true, false, false, true]
        7
      when [false, true, false, true, true, true, true, true, true]
        8
      when [false, true, false, true, true, true, false, true, true]
        9
      else
        nil
      end
    end
  end
end

Ocr::Processor.run
