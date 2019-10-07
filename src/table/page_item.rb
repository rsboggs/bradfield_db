module Table
  class PageItem
    attr_accessor :page_record_offset

    PAGE_ITEM_BIT_WIDTH = 8

    def initialize(page_record_offset:, file_wrapper:)
      @page_record_offset = page_record_offset
      @file_wrapper = file_wrapper
    end

    def save(location:)
      @file_wrapper.seek(location)
      @file_wrapper.write(long.serialize(@page_record_offset))
    end

    def width
      PAGE_BIT_WIDTH
    end

    def long
      ::DataTypes::Long.new
    end
  end
end
