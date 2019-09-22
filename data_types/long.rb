module DataTypes
  class Long
    attr_reader :field_width

    def initialize
      @field_width = 8
    end

    def serialize(value)
      [value.to_i].pack("L!")
    end

    def deserialize(value)
      value.unpack("L!").first
    end
  end
end
