module DataTypes
  class Long

    def to_binary(value)
      [value.to_i].pack("L!")
    end

    def from_binary(value)
      value.unpack("L!").first
    end

  end
end
