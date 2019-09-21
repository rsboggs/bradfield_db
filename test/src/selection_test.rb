require "./test/test"

module Src
  class SelectionTest < Minitest::Test
    def test_can_use_equals_operator
      scan = ::Scan.new([
        [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
        [2, "Jumanji (1995)", "Adventure|Children|Fantasy"],
        [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
      ])
      selection = Selection.new(
        child: scan,
        table: "movies",
        filters: ["genres", "EQUALS", "Adventure|Children|Fantasy"]
      )
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], selection.next
      assert_nil selection.next
    end

    def test_can_use_greater_than_operator
      scan = ::Scan.new([
        [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
        [2, "Jumanji (1995)", "Adventure|Children|Fantasy"],
        [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
      ])
      selection = Selection.new(
        child: scan,
        table: "movies",
        filters: ["movieId", "GREATER_THAN", 1]
      )
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], selection.next
      assert_equal [3, "Grumpier Old Men (1995)", "Comedy|Romance"], selection.next
      assert_nil selection.next
    end

    def test_can_use_less_than_operator
      scan = ::Scan.new([
        [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
        [2, "Jumanji (1995)", "Adventure|Children|Fantasy"],
        [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
      ])
      selection = Selection.new(
        child: scan,
        table: "movies",
        filters: ["movieId", "LESS_THAN", 2]
      )
      assert_equal [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], selection.next
      assert_nil selection.next
    end
  end
end
