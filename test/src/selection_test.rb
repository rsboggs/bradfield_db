require "./test/test"

module Src
  class SelectionTest < Minitest::Test
    def setup
      ::Support::Helper.setup_test_data("movies")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
    end

    def test_can_use_equals_operator
      selection = Selection.new(
        child: ::FileScan.new(table: "movies"),
        table: "movies",
        filters: ["genres", "EQUALS", "Adventure|Children|Fantasy"]
      )
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], selection.next
      assert_nil selection.next
    end

    def test_can_use_greater_than_operator
      selection = Selection.new(
        child: ::FileScan.new(table: "movies"),
        table: "movies",
        filters: ["movieId", "GREATER_THAN", 8]
      )
      assert_equal [9, "Sudden Death (1995)", "Action"], selection.next
      assert_equal [10, "GoldenEye (1995)", "Action|Adventure|Thriller"], selection.next
      assert_nil selection.next
    end

    def test_can_use_less_than_operator
      selection = Selection.new(
        child: ::FileScan.new(table: "movies"),
        table: "movies",
        filters: ["movieId", "LESS_THAN", 2]
      )
      assert_equal [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], selection.next
      assert_nil selection.next
    end
  end
end
