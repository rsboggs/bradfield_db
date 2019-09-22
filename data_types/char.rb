module DataTypes
  class Char
    attr_reader :field_width

    def initialize(field_length)
      @field_length = field_length
      @field_width = field_length * 8
    end

    def serialize(value)
      value.unpack("B*").first + Long.new.serialize(0) * (@field_length - value.length)
    end

    def deserialize(value)
      [value].pack("B*").gsub(/\000/, "")
    end
  end
end
