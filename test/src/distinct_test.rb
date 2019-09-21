require "./test/test"

module Src
  class DistinctTest < Test
    def test_next_returns_distinct_values
      scan = Scan.new([
        [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
        [2, "Toy Story (1995)", "Adventure|Children|Fantasy"],
        [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
      ])
      distinct = Distinct.new(
        child: scan,
        table: "movies",
        column: "title"
      )
      assert_equal "Toy Story (1995)", distinct.next
      assert_equal "Grumpier Old Men (1995)", distinct.next
      assert_nil distinct.next
    end
  end
end
