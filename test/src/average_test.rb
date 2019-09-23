require "./test/test"

module Src
  class AverageTest < Test
    def setup
      fw = ::FileWrapper::Backfill.new(
        csv_file_name: "test/data/movies.csv",
        output_file_name: "test/data/movies_test.bin",
        table: "movies"
      )
      fw.perform
    end

    def teardown
      File.truncate("test/data/movies_test.bin", 0)
    end

    def test_next_returns_average_of_column
      average = Average.new(
        child: ::FileScan.new(table: "movies"),
        table: "movies",
        column: "movieId"
      )
      # Rounds from 5.5
      assert_equal 5, average.next
      assert_nil average.next
    end
  end
end
