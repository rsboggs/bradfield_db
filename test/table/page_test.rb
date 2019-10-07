require "./test/test"

module Table
  class PageTest < Test
    def test_can_insert_record_returns_true_if_enough_space
      assert page.can_insert_record?(record)
    end

    def test_insert_record
      page.insert_record(record)

      # TODO: check page updated
      # TODO: check page_header updated
    end

    def test_width
      assert_equal 64_000, page.width
    end

    def test_page_item_width
      assert_equal 8, page.page_item_width
    end

    private

    def record
      ::Table::PageRecord.new(
        table: "movies",
        values: [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"]
      )
    end

    def page
      ::Table::Page.new(page_content: page_content)
    end

    def page_content
      long = ::DataTypes::Long.new
      long.serialize(6) + long.serialize(900) + long.serialize(1_000)
    end
  end
end
