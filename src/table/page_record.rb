module Table
  class PageRecord
    def initialize(table:, file_wrapper:, values:)
      @schema = ::DataTypes::Schema.new(table: table)
      @serialized_value = @schema.types.map.with_index do |type, index|
        serialize_value(type, values[index])
      end
      @file_wrapper = file_wrapper
    end

    def save(location:)
      @file_wrapper.seek(location)
      @file_wrapper.write(@serialized_value.join(""))
    end

    def width
      @serialized_value.join("").length
    end

    private

    def serialize_value(type, value)
      type.serialize(value)
    end
  end
end
