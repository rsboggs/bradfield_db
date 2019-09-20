require "./test/test"

module Src
  class AverageTest < Test
    def test_next_returns_average_of_column
      scan = Scan.new([
        [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
        [2, "Jumanji (1995)", "Adventure|Children|Fantasy"],
        [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
      ])
      average = Average.new(
        scan,
        "movieId"
      )
      assert_equal 2, average.next
      assert_nil average.next
    end
  end
end
