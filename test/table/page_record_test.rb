require "./test/test"

module Table
  class PageRecordTest < Test
    def test_returns_width
      assert_equal 123, record.width
    end

    private

    def record
      ::Table::PageRecord.new(
        table: "movies",
        values: {
          "movieId" => 1,
          "title" => "Toy Story (1995)",
          "genres" => "Adventure|Animation|Children|Comedy|Fantasy"
        }
      )
    end
  end
end
