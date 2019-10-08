require_relative "../../data_types/schema"
require_relative "../../file_wrapper/base"

module Table
  class Base
    def initialize(table:)
      @schema = ::DataTypes::Schema.new(table: table)
      @table = table
      reset_scan
    end

    def insert_record(values)
      record = ::Table::PageRecord.new(
        table: @table,
        file_wrapper: @file_wrapper,
        values: values
      )

      while @current_page
      #   return @current_page.insert_record(record) if @current_page.can_insert_record?(record)

        set_next_page
      end

      # No space on existing pages for new record
      @current_page = create_new_page
      @file_wrapper.seek(-page_width)
      @current_page.insert_record(record)
    end

    def next_record
      while @current_page
        record = @current_page.next_record
        return record if record

        set_next_page
      end

      nil
    end

    def reset_scan
      @file_wrapper = FileWrapper::Base.new(table_file: @schema.table_file_name)
      set_next_page
    end

    private

    def set_next_page
      @current_page = next_page
    end

    def next_page
      return nil if @file_wrapper.end_of_file?

      page_content = @file_wrapper.read(page_width)
      ::Table::Page.new(page_content: page_content, file_wrapper: @file_wrapper, schema: @schema)
    end

    def create_new_page
      table_page = ::Table::Page.new(page_content: nil, file_wrapper: @file_wrapper, schema: @schema)
      table_page.create
      table_page
    end

    def page_width
      ::Table::Page::PAGE_BIT_WIDTH
    end
  end
end
