require "./test/test"

module Src
  class DistinctTest < Test
    def setup
      ::Support::Helper.setup_test_data("movies")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
    end

    def test_next_returns_distinct_values
      sorted = Sort.new(
        child: ::FileScan.new(table: "movies"),
        table: "movies",
        column: "title"
      )
      distinct = Distinct.new(
        child: sorted,
        table: "movies",
        column: "title"
      )
      # Only 9/10 since filter out duplicate
      assert_equal "Father of the Bride Part II (1995)", distinct.next
      assert_equal "GoldenEye (1995)", distinct.next
      assert_equal "Grumpier Old Men (1995)", distinct.next
      assert_equal "Heat (1995)", distinct.next
      assert_equal "Jumanji (1995)", distinct.next
      assert_equal "Sabrina (1995)", distinct.next
      assert_equal "Sudden Death (1995)", distinct.next
      assert_equal "Toy Story (1995)", distinct.next
      assert_equal "Waiting to Exhale (1995)", distinct.next
      assert_nil distinct.next
    end
  end
end
