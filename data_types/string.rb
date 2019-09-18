module DataTypes
  class String

    # TODO attach string length to beginning
    def to_binary(value)
      value.unpack("B*").first
    end

    def from_binary(value)
      [value].pack("B*")
    end

  end
end
