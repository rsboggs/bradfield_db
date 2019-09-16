require "minitest/autorun"
require "./src/selection.rb"
require "./src/scan.rb"

class SelectionTest < Minitest::Test
  def test_next_returns_filtered_items
    selection = Selection.new(Scan.new([1, 2, 3]), &:odd?)
    assert_equal 1, selection.next
    assert_equal 3, selection.next
    assert_nil selection.next
  end
end
