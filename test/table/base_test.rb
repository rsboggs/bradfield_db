require "./test/test"

module Table
  class BaseTest < Test
    def teardown
      File.truncate("test/data/movies_test.bin", 0)
    end

    def test_insert_record
      table_base.insert_record(values)
    end

    def test_next_record
      table_base.insert_record(values)

      assert_equal values, table_base.next_record
    end

    # def test_reset_scan
    # end

    private

    def table_base
      ::Table::Base.new(table: "movies")
    end

    def values
      [
        1,
        "Toy Story (1995)",
        "Adventure|Animation|Children|Comedy|Fantasy"
      ]
    end
  end
end
