require "minitest/autorun"
require "./src/scan.rb"
require "./src/projection.rb"

class ProjectionTest < Minitest::Test
  def test_next_returns_only_fields_specified
    scan = Scan.new([
      [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"],
      [2, "Jumanji (1995)", "Adventure|Children|Fantasy"],
      [3, "Grumpier Old Men (1995)", "Comedy|Romance"],
    ])
    projection = Projection.new(
      scan,
      %w[movieId title]
    )
    assert_equal [1, "Toy Story (1995)"], projection.next
    assert_equal [2, "Jumanji (1995)"], projection.next
    assert_equal [3, "Grumpier Old Men (1995)"], projection.next
    assert_nil projection.next
  end
end
