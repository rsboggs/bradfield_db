require "./test/test"

module Src
  class NestedLoopsJoinTest < Test
    def setup
      ::Support::Helper.setup_test_data("movies")
      ::Support::Helper.setup_test_data("ratings")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
      ::Support::Helper.setup_test_data("ratings")
    end

    def test_next_returns_joined_data
      nested_join = NestedLoopsJoin.new(
        child1: FileScan.new(table: "movies"),
        child2: FileScan.new(table: "ratings"),
        theta: lambda do |record1, record2|
          record1[0] == record2[2]
        end
      )

      assert_equal(
        [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy", 1, 80766, 1, 5],
        nested_join.next
      )
      assert_equal(
        [1,"Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy", 2, 80767, 1, 4],
        nested_join.next
      )
      assert_equal(
        [2, "Jumanji (1995)", "Adventure|Children|Fantasy", 3, 80766, 2, 4],
        nested_join.next
      )
      assert_nil nested_join.next
    end
  end
end
