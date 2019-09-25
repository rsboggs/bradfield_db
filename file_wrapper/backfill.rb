require "csv"
require_relative "base"
require_relative "../data_types/long"
require_relative "../data_types/char"

module FileWrapper
  class Backfill
    def initialize(csv_file_name:, output_file_name:, table:)
      @csv_file_name = csv_file_name
      @output_file_name = output_file_name
      @schema = ::DataTypes::Schema.new(table: table)
    end

    def perform
      file_wrapper = FileWrapper::Base.new(table_file: @output_file_name)

      CSV.foreach(@csv_file_name, headers: true) do |row|
        @schema.fields.each_with_index do |column_name, index|
          file_wrapper.write(serialize_value(row.to_h, column_name, index))
        end
      end

      file_wrapper.close
    end

    private

    def serialize_value(record, column_name, index)
      data_instance = @schema.types[index]
      data_instance.serialize(record[column_name])
    end

    def page_size
      ::FileWrapper::TableReader::PAGE_SIZE
    end
  end
end
