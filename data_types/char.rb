module DataTypes
  class Char
    class << self
      def serialize(value, field_length)
        value.unpack("B*").first + Long.serialize(0) * (field_length - value.length)
      end

      def deserialize(value)
        [value].pack("B*").gsub(/\000/, "")
      end
    end
  end
end
