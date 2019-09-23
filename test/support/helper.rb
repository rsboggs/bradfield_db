module Support
  class Helper
    class << self
      def setup_test_data(table)
        fw = ::FileWrapper::Backfill.new(
          csv_file_name: "test/data/#{table}.csv",
          output_file_name: "test/data/#{table}_test.bin",
          table: table
        )
        fw.perform
      end

      def teardown_test_data(table)
        File.truncate("test/data/#{table}_test.bin", 0)
      end
    end
  end
end
