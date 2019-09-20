module DataTypes
  class Long
    class << self
      def serialize(value)
        [value.to_i].pack("L!")
      end

      def deserialize(value)
        value.unpack("L!").first
      end
    end
  end
end
