require "./test/test"

module Src
  class SortMergeJoinTest < Test
    def setup
      ::Support::Helper.setup_test_data("movies")
      ::Support::Helper.setup_test_data("ratings")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
      ::Support::Helper.setup_test_data("ratings")
    end

    def test_next_returns_joined_data
      sort_merge_join = SortMergeJoin.new(
        child1: Sort.new(
          child: ::FileScan.new(table: "movies"),
          table: "movies",
          column: "movieId",
        ),
        child2: Sort.new(
          child: ::FileScan.new(table: "ratings"),
          table: "ratings",
          column: "movieId",
        ),
        child1_index: 0,
        child2_index: 2
      )

      # TODO
      # assert_equal(
      #   [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy", 1, 80766, 1, 5],
      #   sort_merge_join.next
      # )
      # assert_equal(
      #   [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy", 2, 80767, 1, 4],
      #   sort_merge_join.next
      # )
      # assert_equal(
      #   [2, "Jumanji (1995)", "Adventure|Children|Fantasy", 3, 80766, 2, 4],
      #   sort_merge_join.next
      # )
      # assert_nil sort_merge_join.next
    end
  end
end
