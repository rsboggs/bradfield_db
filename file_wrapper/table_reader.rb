require_relative "base"
require_relative "../data_types/long"
require_relative "../data_types/string"

module FileWrapper
  class TableReader
    def initialize(table_name: "data/movies.bin")
      @table_name = table_name
      @schema = %w[movieId title genres]
      @types = %w[Long String String]
    end

    def perform
      file_wrapper = FileWrapper::Base.new(table_file: @table_name)
      # TODO: read fixed width of data
      data = file_wrapper.read
      # TODO: process convert data from binary
      puts data
    end

    private

    def non_binary_value(record, column_name, index)
      data_klass = ::DataTypes.const_get(@types[index])
      data_klass.new.from_binary(record[column_name])
    end
  end
end
