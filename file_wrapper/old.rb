require "pry"

module FileWrapper
  class Base
    def initialize(data_name: "src/data.bin")
      @current_file = File.open(data_name, "r+")
    end

    def seek(change)
      @current_file.seek(change)
    end

    def write(value, type)
      bin_value = convert_to_binary(value, type)
      File.write(@current_file, bin_value)
    end

    def read(type)
      bin_value = @current_file.read
      convert_from_binary(bin_value, type)
    end

    def close
      @current_file.close
    end

    private

    def current_position
      @current_file.pos
    end

    def convert_to_binary(value, type)
      if type == "long"
        [value].pack("L!")
      elsif type == "string"
        value.unpack("B*").first
      else
        raise NotImplementedError
      end
    end

    def convert_from_binary(value, type)
      if type == "long"
        value.unpack("L!").first
      elsif type == "string"
        [value].pack("B*")
      else
        raise NotImplementedError
      end
    end
  end
end
