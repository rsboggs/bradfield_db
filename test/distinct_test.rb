require "minitest/autorun"
require "./src/scan.rb"
require "./src/distinct.rb"

class DistinctTest < Minitest::Test
  def test_next_returns_distinct_values
    scan = Scan.new([
      [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
      [2, "Toy Story (1995)", "Adventure|Children|Fantasy"],
      [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
    ])
    distinct = Distinct.new(
      scan,
      "title"
    )
    assert_equal "Toy Story (1995)", distinct.next
    assert_equal "Grumpier Old Men (1995)", distinct.next
    assert_nil distinct.next
  end
end
