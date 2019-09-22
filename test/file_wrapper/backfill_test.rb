require "./test/test"

module FileWrapper
  class BackfillTest < Test
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

      tr = ::FileWrapper::TableReader.new(
        table_file_name: "test/data/movies_test.bin",
        table: "movies"
      )
      assert_equal(
        [1,"Toy Story (1995)","Adventure|Animation|Children|Comedy|Fantasy"],
        tr.next_record
      )
      9.times do
        refute_nil tr.next_record
      end
      assert_nil tr.next_record
    end
  end
end
