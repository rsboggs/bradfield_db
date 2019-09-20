module DataTypes
  class Char
    def initialize(field_length)
      @field_length = field_length
    end

    def serialize(value)
      value.unpack("B*").first + Long.new.serialize(0) * (@field_length - value.length)
    end

    def deserialize(value)
      [value].pack("B*").gsub(/\000/, "")
    end
  end
end
