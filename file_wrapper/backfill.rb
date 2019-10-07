require "csv"

module FileWrapper
  class Backfill
    def initialize(csv_file_name:, table:)
      @csv_file_name = csv_file_name
      @table = table
      @table_base = ::Table::Base.new(table: @table)
    end

    def perform
      CSV.foreach(@csv_file_name, headers: true) do |row|
        @table_base.insert_record(row.to_h)
      end
    end
  end
end
