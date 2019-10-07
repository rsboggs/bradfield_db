require "./test/test"

module Table
  class BaseTest < Test
    def teardown
      File.truncate("test/data/movies_test.bin", 0)
    end

    def test_insert_record
      values = [
        1,
        "Toy Story (1995)",
        "Adventure|Animation|Children|Comedy|Fantasy"
      ]
      table_base.insert_record(values)
      # Check page
    end

    # def test_next_record
    # end

    # def test_reset_scan
    # end

    private

    def table_base
      ::Table::Base.new(table: "movies")
    end
  end
end
