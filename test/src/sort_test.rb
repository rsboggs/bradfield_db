require "./test/test"

module Src
  class SortTest < Minitest::Test
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

    def test_can_sort_values
      sort = Sort.new(
        child: ::FileScan.new(table_file_name: "test/data/movies_test.bin", table: "movies"),
        table: "movies",
        column: "title",
      )
      assert_equal [5, "Father of the Bride Part II (1995)", "Comedy"], sort.next
      assert_equal [10, "GoldenEye (1995)", "Action|Adventure|Thriller"], sort.next
      assert_equal [3, "Grumpier Old Men (1995)", "Comedy|Romance"], sort.next
      assert_equal [6, "Heat (1995)", "Action|Crime|Thriller"], sort.next
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], sort.next
      assert_equal [7, "Sabrina (1995)", "Comedy|Romance"], sort.next
      assert_equal [9, "Sudden Death (1995)", "Action"], sort.next
      assert_equal [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], sort.next
      assert_equal [8, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], sort.next
      assert_equal [4, "Waiting to Exhale (1995)", "Comedy|Drama|Romance"], sort.next
      assert_nil sort.next
    end
  end
end
