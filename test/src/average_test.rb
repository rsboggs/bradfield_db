require "./test/test"

module Src
  class AverageTest < Test
    def setup
      ::Support::Helper.setup_test_data("movies")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
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
