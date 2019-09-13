require "minitest/autorun"
require "./src/scan.rb"

class ScanIterator < Minitest::Test
  def test_next_returns_each_item
    scan = Scan.new([1, 2, 3])
    assert_equal 1, scan.next
    assert_equal 2, scan.next
    assert_equal 3, scan.next
    assert_nil scan.next
  end
end
