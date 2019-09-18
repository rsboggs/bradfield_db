require "pry"

module FileWrapper
  class Base
    def initialize(table_file: "data/data.bin")
      @current_file = File.new(table_file, "a+")
    end

    def seek(change)
      @current_file.seek(change)
    end

    def write(value)
      @current_file.write(value)
    end

    def read
      @current_file.read
    end

    def close
      @current_file.close
    end
  end
end
