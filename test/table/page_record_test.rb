require "./test/test"

module Table
  class PageRecordTest < Test
    def test_returns_width
      assert_equal 8 + 255 * 8 * 2, record.width
    end

    private

    def record
      table = "movies"
      @schema = ::DataTypes::Schema.new(table: table)

      ::Table::PageRecord.new(
        table: table,
        values: [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
        file_wrapper: ::FileWrapper::Base.new(table_file: @schema.table_file_name)
      )
    end
  end
end
