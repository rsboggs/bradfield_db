require "./test/test"

module Table
  class PageHeaderTest < Test
    def test_sets_correct_instance_variables
      page_header = ::Table::PageHeader.new(page: page)
      assert_equal 6, page_header.page_index
      assert_equal 900, page_header.instance_variable_get("@free_space_start")
      assert_equal 1_000, page_header.instance_variable_get("@free_space_end")
    end

    def test_remaining_space
      page_header = ::Table::PageHeader.new(page: page)
      assert_equal 100, page_header.remaining_space
    end

    def test_increment_space_offsets
      page_header = ::Table::PageHeader.new(page: page)
      page_header.increment_space_offsets(10, 40)
      assert_equal 6, page_header.page_index
      assert_equal 910, page_header.instance_variable_get("@free_space_start")
      assert_equal 960, page_header.instance_variable_get("@free_space_end")
    end

    # TODO: need to save page header to disk

    private

    def page
      long = ::DataTypes::Long.new
      long.serialize(6) + long.serialize(900) + long.serialize(1_000)
    end
  end
end
