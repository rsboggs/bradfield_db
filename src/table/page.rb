module Table
  class Page
    PAGE_BIT_WIDTH = 8 * 1000 * 8

    def initialize(page_content:, file_wrapper:)
      @page_header = ::Table::PageHeader.new(
        page: page_content,
        file_wrapper: file_wrapper,
        new_page: page_content.nil?
      )
      @file_wrapper = file_wrapper
      @page_content = page_content
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

      start_offset = page_item_width
      end_offset = record.width
      @page_header.increment_space_offsets(start_offset, end_offset)
    end

    # def next_record
    #   record = []
    #   # current_index = 0
    #   # @schema.types.each do |type|
    #   #   next_value = binary_value[current_index...(current_index + type.field_width)]
    #   #   record << type.deserialize(next_value)
    #   #   current_index += type.field_width
    #   # end

    #   record
    # end

    private

    def save_record(record)
      record_location = @page_header.free_space_end - record.width
      record.save(location: record_location)
      # page_item = ::Table::PageItem.new(page_record_offset: record_location)
      # page_item.save(location: @page_header.free_space_start)

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
