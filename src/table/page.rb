module Table
  class Page
    PAGE_BIT_WIDTH = 8 * 1000 * 8

    def initialize(page_content:, file_wrapper:, schema:)
      @page_header = ::Table::PageHeader.new(
        page: page_content,
        file_wrapper: file_wrapper,
        new_page: page_content.nil?
      )
      @file_wrapper = file_wrapper
      @schema = schema
      @page_content = page_content
      @current_position = 16
      @page_item_end_position = @page_header.free_space_start - 1
    end

    def create
      @page_header.create
      @file_wrapper.write(
        long.serialize(0) * ((width - @page_header.width) / long.field_width)
      )
    end

    def can_insert_record?(record)
      page_item_width + record.width > @page_header.remaining_space
    end

    def insert_record(record)
      save_record(record)
    end

    def next_record
      current_record_index_binary = @page_content[@current_position..@page_item_end_position]
      current_record_index = long.deserialize(current_record_index_binary)
      record = []
      @schema.types.each do |type|
        next_value = @page_content[current_record_index...(current_record_index + type.field_width)]
        record << type.deserialize(next_value)
        current_record_index += type.field_width
      end
      binding.pry

      record
    end

    private

    def save_record(record)
      record_location = @page_header.free_space_end - record.width
      page_item_location = @page_header.free_space_start
      page_item = ::Table::PageItem.new(file_wrapper: @file_wrapper, page_record_offset: record_location)

      page_item.save(location: page_item_location)
      @file_wrapper.seek(-(page_item_location + page_item.width))

      record.save(location: record_location)
      @file_wrapper.seek(-(record_location + record.width))

      @page_header.increment_space_offsets(page_item_width, record.width)
    end

    def long
      ::DataTypes::Long.new
    end

    def width
      PAGE_BIT_WIDTH
    end

    def page_item_width
      ::Table::PageItem::PAGE_ITEM_BIT_WIDTH
    end
  end
end
