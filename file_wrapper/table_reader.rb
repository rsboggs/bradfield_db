require_relative "base"
require_relative "../data_types/long"
require_relative "../data_types/char"
require_relative "../data_types/schema"

module FileWrapper
  class TableReader
    def initialize(table:)
      @schema = ::DataTypes::Schema.new(table: table)
      @file_wrapper = FileWrapper::Base.new(table_file: @schema.table_file_name)
    end

    def next_record
      return nil if @file_wrapper.end_of_file?

      record = []
      @schema.types.each do |type|
        next_value = @file_wrapper.read(type.field_width)
        record << type.deserialize(next_value)
      end
      record
    end

  end
end
