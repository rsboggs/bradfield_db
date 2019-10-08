require "./test/test"

module Src
  class HashJoinTest < Test
    def setup
      ::Support::Helper.setup_test_data("movies")
      ::Support::Helper.setup_test_data("ratings")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
      ::Support::Helper.teardown_test_data("ratings")
    end

    def test_next_returns_joined_data
      hash_join = HashJoin.new(
        child1: FileScan.new(table: "movies"),
        child2: FileScan.new(table: "ratings"),
        child1_index: 0,
        child2_index: 2
      )

      assert_equal(
        [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy", 1, 80766, 1, 5],
        hash_join.next
      )
      assert_equal(
        [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy", 2, 80767, 1, 4],
        hash_join.next
      )
      assert_equal(
        [2, "Jumanji (1995)", "Adventure|Children|Fantasy", 3, 80766, 2, 4],
        hash_join.next
      )
      assert_nil hash_join.next
    end
  end
end
