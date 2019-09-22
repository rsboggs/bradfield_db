require "./test/test"

module Src
  class SelectionTest < Minitest::Test
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

    def test_can_use_equals_operator
      selection = Selection.new(
        child: ::FileScan.new(table_file_name: "test/data/movies_test.bin", table: "movies"),
        table: "movies",
        filters: ["genres", "EQUALS", "Adventure|Children|Fantasy"]
      )
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], selection.next
      assert_nil selection.next
    end

    def test_can_use_greater_than_operator
      selection = Selection.new(
        child: ::FileScan.new(table_file_name: "test/data/movies_test.bin", table: "movies"),
        table: "movies",
        filters: ["movieId", "GREATER_THAN", 8]
      )
      assert_equal [9, "Sudden Death (1995)", "Action"], selection.next
      assert_equal [10, "GoldenEye (1995)", "Action|Adventure|Thriller"], selection.next
      assert_nil selection.next
    end

    def test_can_use_less_than_operator
      selection = Selection.new(
        child: ::FileScan.new(table_file_name: "test/data/movies_test.bin", table: "movies"),
        table: "movies",
        filters: ["movieId", "LESS_THAN", 2]
      )
      assert_equal [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], selection.next
      assert_nil selection.next
    end
  end
end
