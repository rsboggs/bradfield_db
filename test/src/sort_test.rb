require "./test/test"

module Src
  class SortTest < Minitest::Test
    def test_can_sort_values
      scan = Scan.new([
        [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
        [2, "Jumanji (1995)", "Adventure|Children|Fantasy"],
        [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
      ])
      sort = Sort.new(
        child: scan,
        table: "movies",
        column: "title",
      )
      assert_equal [3, "Grumpier Old Men (1995)", "Comedy|Romance"], sort.next
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], sort.next
      assert_equal [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], sort.next
      assert_nil sort.next
    end
  end
end
