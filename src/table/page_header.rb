module Table
  class PageHeader
    attr_reader :page_index, :free_space_end, :free_space_start

    def initialize(page:, file_wrapper:, new_page:)
      @file_wrapper = file_wrapper
      @page_content = page
      if new_page
        @free_space_start = width
        @free_space_end = page_width
      else
        @free_space_start, @free_space_end = read_page_header(page)
      end
    end

    def remaining_space
      @free_space_end - @free_space_start
    end

    def increment_space_offsets(start_offset, end_offset)
      @free_space_start += start_offset
      @free_space_end -= end_offset
      save_header_data
    end

    def create
      save_header_data
    end

    def width
      long.field_width * 2
    end

    private

    def read_page_header(page)
      record = []
      current_index = 0

      2.times do
        next_value = page[current_index...(current_index + long.field_width)]
        record << long.deserialize(next_value)
        current_index += long.field_width
      end

      record
    end

    def save_header_data(reset_position: false)
      @file_wrapper.write(long.serialize(@free_space_start))
      @file_wrapper.write(long.serialize(@free_space_end))
      @file_wrapper.seek(-width) if reset_position
    end

    def long
      ::DataTypes::Long.new
    end

    def page_width
      ::Table::Page::PAGE_BIT_WIDTH
    end
  end
end
