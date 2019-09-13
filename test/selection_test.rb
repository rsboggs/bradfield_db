require "minitest/autorun"
require "./src/selection.rb"

class SelectionIterator < Minitest::Test
  def test_next_returns_each_item
    selection = Selection.new([1, 2, 3], &:odd?)
    assert_equal 1, selection.next
    assert_equal 3, selection.next
    assert_nil selection.next
  end
end

