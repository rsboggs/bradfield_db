module DataTypes
  class Long

    def to_binary(value)
      [value.to_i].pack("L!")
    end

  end
end
