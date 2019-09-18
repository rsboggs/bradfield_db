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
        record = row.to_h
        @schema.each_with_index do |column_name, index|
          data_klass = ::DataTypes.const_get(@types[index])
          binary_value = data_klass.new.to_binary(record[column_name])
          file_wrapper.write(binary_value)
        end
      end

      file_wrapper.close
    end
  end
end
