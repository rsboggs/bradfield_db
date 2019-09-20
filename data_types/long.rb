module DataTypes
  class Long
    def serialize(value)
      [value.to_i].pack("L!")
    end

    def deserialize(value)
      value.unpack("L!").first
    end
  end
end
