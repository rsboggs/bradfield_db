require "./test/test"

module FileWrapper
  class BackfillTest < Test
    def setup
      # Allow 1 record per page
      ::FileWrapper::Backfill.any_instance.stubs(:page_size).returns(4088 * 3)
      ::FileWrapper::TableReader.any_instance.stubs(:page_size).returns(4088 * 3)
    end

    def teardown
      File.truncate("test/data/movies_test.bin", 0)
    end

    def test_creates_backfill_files
      fw = ::FileWrapper::Backfill.new(
        csv_file_name: "test/data/movies.csv",
        output_file_name: "test/data/movies_test.bin",
        table: "movies"
      )
      fw.perform

      tr = ::FileWrapper::TableReader.new(table: "movies")
      assert_equal(
        [1,"Toy Story (1995)","Adventure|Animation|Children|Comedy|Fantasy"],
        tr.next
      )
      9.times do
        refute_nil tr.next
      end
      assert_nil tr.next
    end
  end
end
