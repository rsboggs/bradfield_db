require "./test/test"

module Src
  class NestedLoopsJoinTest < Test
    def setup
      fw = ::FileWrapper::Backfill.new(
        csv_file_name: "test/data/movies.csv",
        output_file_name: "test/data/movies_test.bin",
        table: "movies"
      )
      fw.perform

      fw = ::FileWrapper::Backfill.new(
        csv_file_name: "test/data/ratings.csv",
        output_file_name: "test/data/ratings_test.bin",
        table: "ratings"
      )
      fw.perform
    end

    def teardown
      File.truncate("test/data/movies_test.bin", 0)
      File.truncate("test/data/ratings_test.bin", 0)
    end

    def test_next_returns_joined_data
      nested_join = NestedLoopsJoin.new(
        child1: FileScan.new(table: "movies"),
        child2: FileScan.new(table: "ratings"),
        table1: "movies",
        table2: "ratings",
        column1: "movieId",
        column2: "movieId"
      )

      assert_equal(
        [
          [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
          [1, 80766, 1, 5],
        ],
        nested_join.next
      )
      assert_equal(
        [
          [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
          [2, 80767, 1, 4],
        ],
        nested_join.next
      )
      assert_equal(
        [
          [2, "Jumanji (1995)", "Adventure|Children|Fantasy"],
          [3, 80766, 2, 4],
        ],
        nested_join.next
      )
      assert_nil nested_join.next
    end
  end
end
