module FileWrapper
  class Base
    def initialize(table_file: )
      @current_file = File.new(table_file, "rb+")
    end

    def seek(change)
      @current_file.seek(change)
    end

    def write(value)
      @current_file.write(value)
    end

    def read(count = nil)
      if count
        @current_file.read(count)
      else
        @current_file.read
      end
    end

    def close
      @current_file.close
    end

    def end_of_file?
      @current_file.eof?
    end
  end
end
