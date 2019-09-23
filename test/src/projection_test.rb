require "./test/test"

module Src
  class ProjectionTest < Test
    def setup
      ::Support::Helper.setup_test_data("movies")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
    end

    def test_next_returns_only_fields_specified
      projection = Projection.new(
        child: ::FileScan.new(table: "movies"),
        table: "movies",
        columns: %w[movieId title]
      )
      assert_equal [1, "Toy Story (1995)"], projection.next
      assert_equal [2, "Jumanji (1995)"], projection.next
      assert_equal [3, "Grumpier Old Men (1995)"], projection.next
      assert_equal [4, "Waiting to Exhale (1995)"], projection.next
      assert_equal [5, "Father of the Bride Part II (1995)"], projection.next
      assert_equal [6, "Heat (1995)"], projection.next
      assert_equal [7, "Sabrina (1995)"], projection.next
      assert_equal [8, "Toy Story (1995)"], projection.next
      assert_equal [9, "Sudden Death (1995)"], projection.next
      assert_equal [10, "GoldenEye (1995)"], projection.next
      assert_nil projection.next
    end
  end
end
