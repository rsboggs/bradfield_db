require "csv"
require_relative "base"
require_relative "../data_types/long"
require_relative "../data_types/string"

module FileWrapper
  class Backfill
    def initialize(csv_file_name:)
      @csv_file_name = csv_file_name
      @schema = %w[movieId title genres]
      @types = %w[Long String String]
    end

    def perform
      file_wrapper = FileWrapper::Base.new(table_file: "data/movies.bin")

      CSV.foreach(@csv_file_name, headers: true) do |row|
        @schema.each_with_index do |column_name, index|
          file_wrapper.write(binary_value(row.to_h, column_name, index))
        end
      end

      file_wrapper.close
    end

    private

    def binary_value(record, column_name, index)
      data_klass = ::DataTypes.const_get(@types[index])
      data_klass.new.to_binary(record[column_name])
    end
  end
end
