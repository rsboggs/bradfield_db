module DataTypes
  class String

    # TODO attach string length to beginning
    def to_binary(value)
      value.unpack("B*").first
    end

  end
end