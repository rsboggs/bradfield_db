module DataTypes
  class String
    def to_binary(value)
      [value.length].pack("L!") + value.unpack("B*").first
    end

    def from_binary(value)
      [value].pack("B*")
    end
  end
end
