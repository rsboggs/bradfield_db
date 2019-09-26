require_relative "base"
require_relative "../data_types/long"
require_relative "../data_types/char"
require_relative "../data_types/schema"

module FileWrapper
  class TableReader
    PAGE_SIZE = 8 * 1000 * 8  # 8 kb

    def initialize(table:)
      @schema = ::DataTypes::Schema.new(table: table)
      @file_wrapper = FileWrapper::Base.new(table_file: @schema.table_file_name)
      @current_page = next_page
      @current_record_index = 0
    end

    def next
      while @current_page
        record_count = @current_page.size / @schema.record_width
        first_index = @schema.record_width * @current_record_index
        last_index = first_index + @schema.record_width

        while record_count.positive? && @current_record_index < record_count
          @current_record_index += 1
          return next_record(@current_page[first_index...last_index])
        end

        @current_page = next_page
        @current_record_index = 0
      end
    end

    def next_record(binary_value)
      record = []
      current_index = 0
      @schema.types.each do |type|
        next_value = binary_value[current_index...(current_index + type.field_width)]
        record << type.deserialize(next_value)
        current_index += type.field_width
      end
      record
    end

    private

    def page_size
      PAGE_SIZE
    end

    def next_page
      return nil if @file_wrapper.end_of_file?

      @file_wrapper.read(page_size)
    end
  end
end
